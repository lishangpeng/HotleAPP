package top.lapa.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeWapPayModel;
import com.alipay.api.request.AlipayTradeWapPayRequest;

import redis.clients.jedis.Jedis;
import top.lapa.web.pay.AlipayConfig;
import top.lsp.util.JedisUtils;
import top.lspa.mapper.OrderMapper;
import top.lspa.pojo.Hotel;
import top.lspa.pojo.Order;
import top.lspa.pojo.Room;
import top.lspa.pojo.User;
import top.lspa.service.HotelService;
import top.lspa.service.OrderService;
import top.lspa.service.RoomService;

@Controller
@RequestMapping("/room")
public class RoomController {
	//表设计的问题 所以在创建order表的时候 需要在roomUser表中也插入数据
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping(value="/order",method=RequestMethod.GET)
	public ModelAndView orderPage(String hotelId,String roomId,String checkInDate,String checkOutDate,HttpServletResponse resp,HttpServletRequest req) throws IOException, ParseException {
		//0代表未付款，1代表已经付款
		//创建的格式 userId=hotelId=roomId=checkInDate=checkOutDate=createDate:date=userId=hotelId=roomId=checkInDate=checkOutDate
		//如果使用下划线不好分割
		Jedis jedis = JedisUtils.getJedis();
		try {
			
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			User user = (User) req.getSession().getAttribute("user");
			if (user==null) {
				resp.getWriter().println("<script type='text/javascript'>alert('请先点击下方登录');history.go(-1);</script>");
				return null;
			}
			StringBuilder sb = new StringBuilder();
			sb.append("*=");
			sb.append(hotelId).append("=").append(roomId).append("=").append(checkInDate).append("=").append(checkOutDate);
			Set<String> set = jedis.keys(sb.toString()); 
			String[] values = null;
			if (set.size()>0) {
				values = set.toArray(new String[set.size()]);
			}
			//如果是自己则可以进入
			if (values!=null) {
				for(int i=0;i<values.length;i++) {
					//房间是自己预定的就可以进入
					if ((values[i].charAt(0)-'0') == user.getId()) {
						Room room = roomService.selectOne(Long.valueOf(roomId));
						Hotel hotel = hotelService.selectOne(Long.valueOf(hotelId));
						ModelAndView modelAndView = new ModelAndView("room/pay");
						modelAndView.addObject("roomName", room.getRoomName());
						modelAndView.addObject("price", room.getPrice());
						modelAndView.addObject("hotelName", hotel.getHotelName());
						return modelAndView;
					}
				}
				//这个房间不是自己预定的
				resp.getWriter().println("<script type='text/javascript'>alert('手速慢了，刚被预定了');history.go(-1);</script>");
				return null;
			}else {
				StringBuilder jValue = new StringBuilder();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				jValue.append(formatter.format(new Date())).append("=").append(sb.toString()).append("=0");
				//1代表不存在，0代表存在，相当于锁的存在
				//sb.toString 这个key相当于一个锁 如果完成了就会把这个时间段的房间锁住
				if (jedis.setnx(sb.toString(), "1")==1) {
					String key = sb.toString().replaceAll("\\*", String.valueOf(user.getId()));
					JedisUtils.setex(key, 5*60, jValue.toString());
					//创建订单成功，插入数据库中，方便用户查看，付款的订单需要往userroom插入一份
					Order order = new Order();
					order.setUserId(user.getId());
					order.setCheckInDate(formatter.parse(checkInDate));
					order.setCheckOutDate(formatter.parse(checkOutDate));
					order.setHotelId(Long.parseLong(hotelId));
					order.setRoomId(Long.parseLong(roomId));
					order.setPayOrNot(false);
					order.setCreateDate(new Date());
					//优化增加了一个createDate字段
					orderService.insert(order);
					
					//todo:五分钟后查询数据库是否付款，如果没有付款就打开锁
					//有个Bug 没删除的时候关闭服务器 timer又会重新从0开始计时
					//todo:优化  后续用quatz实现第二重保障
					Timer timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							List<Boolean> payOrNots = selectPayOrNot(user.getId(), checkInDate, checkOutDate,Long.parseLong(hotelId),Long.parseLong(roomId));
							for(Boolean payOrNot:payOrNots) {
								if (payOrNot) {
									this.cancel();
									return;
								}
							}
							jedis.del(sb.toString());
							//增加一个订单状态orderType设置为失效
							Order orderSetType = orderService.selectOne(order);
							orderSetType.setOrderType("已失效");
							orderService.updateOrderType(orderSetType);
						}
					},1000*60*5);
				}else {
					resp.getWriter().println("<script type='text/javascript'>alert('房间刚被抢走');history.go(-1);</script>");
					return null;
				}
			}
			//todo  将订单的信息查询出来给pay页面
			Room room = roomService.selectOne(Long.valueOf(roomId));
			Hotel hotel = hotelService.selectOne(Long.valueOf(hotelId));
			ModelAndView modelAndView = new ModelAndView("room/pay");
			modelAndView.addObject("roomName", room.getRoomName());
			modelAndView.addObject("price", room.getPrice());
			modelAndView.addObject("hotelName", hotel.getHotelName());
			return modelAndView;
		} finally {
			jedis.close();
		}
	}
	
	private List<Boolean> selectPayOrNot(Long userId,String checkInDate,String checkOutDate,Long hotelId,Long roomId) {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date in = format.parse(checkInDate);
			Date out =  format.parse(checkOutDate);
			
			Order order = new Order();
			order.setHotelId(hotelId);
			order.setRoomId(roomId);
			order.setCheckInDate(in);
			order.setCheckOutDate(out);
			order.setUserId(userId);
			
			return orderService.selectPayOrNot(order);
		} catch (Exception e) {
			throw new RuntimeException("解析错误",e);
		}
	}
	
	/**
	 * 阿里云demo拔下来的代码 没改过 看不懂去找api看
	 * @param userId
	 * @param checkInDate
	 * @param checkOutDate
	 * @param hotelId
	 * @param roomId
	 * @return
	 */
	@RequestMapping(value="/order",method=RequestMethod.POST)
	public void orderSubmit(HttpServletRequest request,HttpServletResponse response) throws IOException {
		if(request.getParameter("WIDout_trade_no")!=null){
			// 商户订单号，商户网站订单系统中唯一订单号，必填
		    String out_trade_no = new String(request.getParameter("WIDout_trade_no").getBytes("ISO-8859-1"),"UTF-8");
			// 订单名称，必填
		    String subject = new String(request.getParameter("WIDsubject").getBytes("ISO-8859-1"),"UTF-8");
			System.out.println(subject);
		    // 付款金额，必填
		    String total_amount=new String(request.getParameter("WIDtotal_amount").getBytes("ISO-8859-1"),"UTF-8");
		    // 商品描述，可空
		    String body = new String(request.getParameter("WIDbody").getBytes("ISO-8859-1"),"UTF-8");
		    // 超时时间 可空
		   String timeout_express="2m";
		    // 销售产品码 必填
		    String product_code="QUICK_WAP_WAY";
		    /**********************/
		    // SDK 公共请求类，包含公共请求参数，以及封装了签名与验签，开发者无需关注签名与验签     
		    //调用RSA签名方式
		    AlipayClient client = new DefaultAlipayClient(AlipayConfig.URL, AlipayConfig.APPID, AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY,AlipayConfig.SIGNTYPE);
		    AlipayTradeWapPayRequest alipay_request=new AlipayTradeWapPayRequest();
		    
		    // 封装请求支付信息
		    AlipayTradeWapPayModel model=new AlipayTradeWapPayModel();
		    model.setOutTradeNo(out_trade_no);
		    model.setSubject(subject);
		    model.setTotalAmount(total_amount);
		    model.setBody(body);
		    model.setTimeoutExpress(timeout_express);
		    model.setProductCode(product_code);
		    alipay_request.setBizModel(model);
		    // 设置异步通知地址
		    alipay_request.setNotifyUrl(AlipayConfig.notify_url);
		    // 设置同步地址
		    alipay_request.setReturnUrl(AlipayConfig.return_url);   
		    
		    // form表单生产
		    String form = "";
			try {
				// 调用SDK生成表单
				form = client.pageExecute(alipay_request).getBody();
				response.setContentType("text/html;charset=" + AlipayConfig.CHARSET); 
			    response.getWriter().write(form);//直接将完整的表单html输出到页面 
			    response.getWriter().flush(); 
			    response.getWriter().close();
			} catch (AlipayApiException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
	}
}

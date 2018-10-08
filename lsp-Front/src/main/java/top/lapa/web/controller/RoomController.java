package top.lapa.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import redis.clients.jedis.Jedis;
import top.lsp.util.JedisUtils;
import top.lspa.pojo.Order;
import top.lspa.pojo.User;
import top.lspa.service.OrderService;

@Controller
@RequestMapping("/room")
public class RoomController {
	//表设计的问题 所以在创建order表的时候 需要在roomUser表中也插入数据
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value="/order")
	public ModelAndView orderPage(String hotelId,String roomId,String checkInDate,String checkOutDate,HttpServletResponse resp,HttpServletRequest req) throws IOException, ParseException {
		//创建订单实际是在redis中放上数据 在10分钟后在写入数据库
		//0代表未付款，1代表已经付款
		//创建的格式 userId=hotelId=roomId=checkInDate=checkOutDate:date=userId=hotelId=roomId=checkInDate=checkOutDate=0
		//如果使用下划线不好分割
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		User user = (User) req.getSession().getAttribute("user");
		if (user==null) {
			resp.getWriter().println("<script type='text/javascript'>alert('请先点击下方登录')</script>");
			return null;
		}
	    StringBuilder sb = new StringBuilder();
	    sb.append("*=");
	    sb.append(hotelId).append("=").append(roomId).append("=").append(checkInDate).append("=").append(checkOutDate);
	    Jedis jedis = JedisUtils.getJedis();
	    Set<String> set = jedis.keys(sb.toString()); 
	    String value = null;
	    if (set.size()>0) {
    		for(String str:set) {
    			value = str;
    		}
	    }
		if (value!=null) {
			resp.getWriter().println("<script type='text/javascript'>alert('手速慢了，刚被预定了');history.go(-1);</script>");
			jedis.close();
			return null;
		}else {
			StringBuilder jValue = new StringBuilder();
			SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd ");
			jValue.append(formatter.format(new Date())).append("=").append(sb.toString()).append("=0");
			String key = sb.toString().replaceAll("\\*", String.valueOf(user.getId()));
			//1代表不存在，0代表存在，相当于锁的存在
			if (jedis.setnx(sb.toString(), "1")==1) {
				JedisUtils.setex(key, 10*60, jValue.toString());
				//todo:十分钟后查询数据库是否付款，如果没有付款就打开锁
				Boolean payOrNot = selectPayOrNot(user.getId(), checkInDate, checkOutDate);
				if (!payOrNot) {
					JedisUtils.del(sb.toString());
				}
			}else {
				resp.getWriter().println("<script type='text/javascript'>alert('房间刚被抢走');history.go(-1);</script>");
			}
		}
		jedis.close();
		ModelAndView modelAndView = new ModelAndView("room/order");
		return modelAndView;
	}
	
	private Boolean selectPayOrNot(Long userId,String checkInDate,String checkOutDate) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date in = format.parse(checkInDate);
		Date out =  format.parse(checkOutDate);
		
		Order order = new Order();
		order.setCheckInDate(in);
		order.setCheckOutDate(out);
		order.setUserId(userId);
		
		return orderService.selectPayOrNot(order);
	}
}

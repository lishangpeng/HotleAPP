package top.lapa.web.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.HttpSolrClient.Builder;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.github.pagehelper.PageInfo;

import top.lsp.util.AjaxResult;
import top.lsp.util.CommonUtils;
import top.lsp.util.ImageCodeUtils;
import top.lsp.util.JedisUtils;
import top.lspa.pojo.Comment;
import top.lspa.pojo.Hotel;
import top.lspa.pojo.Order;
import top.lspa.pojo.Room;
import top.lspa.pojo.User;
import top.lspa.service.CommentService;
import top.lspa.service.HotelService;
import top.lspa.service.OrderService;
import top.lspa.service.RoomService;
import top.lspa.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public ModelAndView registerPage() {
		ModelAndView modelAndView = new ModelAndView("user/register");
		return modelAndView;
	}
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public ModelAndView registerSubmit(User user,String rePassword,String yzm,HttpServletRequest req) {
		
		//39.903740,116.397827  北京天安门的经纬度
		ModelAndView modelAndView = new ModelAndView("user/register");
		if (CommonUtils.isEmpty(user.getCity())) {
			user.setCity("北京");
		}
		if (user.getLat() == null||user.getLng() == null) {
			user.setLat(39.903740);
			user.setLng(116.397827);
		}
		
		if (!CommonUtils.isPhone(user.getPhoneNum())) {
			modelAndView.addObject("message", "不是一个手机号码");
			return modelAndView;
		}
		
		if (!CommonUtils.isIdCard(user.getIdCard())) {
			modelAndView.addObject("message", "不是一个身份证");
			return modelAndView;
		}
		
		if (!CommonUtils.isLengthEnough(user.getPassword(), 6)) {
			modelAndView.addObject("message", "密码长度太短");
			return modelAndView;
		}
		
		if (!ImageCodeUtils.checkImageCode(req.getSession(), yzm)) {
			modelAndView.addObject("message", "验证码不一致");
			return modelAndView;
		}
		
		if (!user.getPassword().equals(rePassword)) {
			modelAndView.addObject("message", "两次密码不一致");
			return modelAndView;
		}
		
		//todo:唯一性判断：
		User userPhoneNum = new User();
		userPhoneNum.setPhoneNum(user.getPhoneNum());
		if (!CommonUtils.isEmpty(userService.selectList(userPhoneNum))) {
			modelAndView.addObject("message", "手机号码已经被注册");
			return modelAndView;
		}
		
		User useridCard = new User();
		useridCard.setIdCard(user.getIdCard());
		if (!CommonUtils.isEmpty(userService.selectList(useridCard))) {
			modelAndView.addObject("message", "身份证号码已经被注册");
			return modelAndView;
		}
		//todo md5加密插入
		
		String salt = UUID.randomUUID().toString();
		String password = CommonUtils.calculateMD5(salt+user.getPassword());
		
		user.setPassword(password);
		user.setPasswordSalt(salt);
		userService.insert(user);
		
		return new ModelAndView("redirect:/user/login");
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView modelAndView = new ModelAndView("user/login");
		return modelAndView;
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public ModelAndView loginSubmit(String info,String password,HttpServletRequest req,HttpServletResponse resp) {
		
		ModelAndView modelAndView = new ModelAndView("user/login");
		User user = new User();
		if (!CommonUtils.isPhone(info)&&!CommonUtils.isIdCard(info)) {
			modelAndView.addObject("message", "帐号或者密码错误");
			return modelAndView;
		}
		if (CommonUtils.isPhone(info)) {
			user.setPhoneNum(info);
		}
		if (CommonUtils.isIdCard(info)) {
			user.setIdCard(info);
		}
		
		user = userService.selectOne(user);
		if (user!=null) {
			
			if (user.getPassword().equals(CommonUtils.calculateMD5(user.getPasswordSalt()+password))) {
				req.getSession().setAttribute("user", user);
				
				//添加到cookie，方便自动登录
				int maxAge = 60 * 60 * 24 * 14;//14天
				Cookie loginNameCookie = new Cookie("loginName", user.getPhoneNum());
				loginNameCookie.setMaxAge(maxAge);
				loginNameCookie.setPath("/");
				resp.addCookie(loginNameCookie);
				
				Cookie passwordCookie = new Cookie("password", CommonUtils.calculateMD5(user.getPasswordSalt()+password));
				passwordCookie.setMaxAge(maxAge);
			    passwordCookie.setPath("/");
			    resp.addCookie(passwordCookie);
				
				
				return new ModelAndView("redirect:/");
			}else {
				modelAndView.addObject("message", "账号或者密码错误");
				return modelAndView;
			}
		}else {
			modelAndView.addObject("message", "此用户还未注册");
			return modelAndView;
		}
	}
	
	//使用sorl 查询
	@RequestMapping("/editCity")
	public @ResponseBody AjaxResult editCity(String cityChange,HttpServletRequest req) throws SolrServerException, IOException {

		HttpSolrClient.Builder bulider = new Builder("http://localhost:8983/solr/region");
		HttpSolrClient solrClient = bulider.build();
		try {
			if (cityChange.isEmpty()) {
				return AjaxResult.errorInstance("城市不能为空");
			}
			SolrQuery query = new SolrQuery("name:"+cityChange);
			
			QueryResponse resp = solrClient.query(query);
			SolrDocumentList docLise = resp.getResults();
			if (docLise.isEmpty()) {
				return AjaxResult.errorInstance("查询不到该城市");
			}
			SolrDocument doc = docLise.get(0);
			List<String> recity =  (List<String>) doc.get("name");
			
			//todo  直接帮第一个结果给用户更改city
/*			User user = (User) req.getSession().getAttribute("user");
			if (user==null) {
				return AjaxResult.errorInstance("请先登录");
			}
			user.setCity(recity.get(0));
			userService.updateCity(user);*/
			return AjaxResult.successInstance(recity.get(0));
		} finally {
			solrClient.close();
		}
	}
	
	@RequestMapping("/changeArea")
	public @ResponseBody AjaxResult changeArea(HttpServletRequest req,String city) throws SolrServerException, IOException {
		
		HttpSolrClient.Builder bulider = new Builder("http://localhost:8983/solr/region");
		HttpSolrClient solrClient = bulider.build();

		try {
			//todo:随着城市改变地区
			List<Object> areaList = new ArrayList<>();
/*			//根据城市查询城市Id
			User user = (User) req.getSession().getAttribute("user");
			if (user==null) {
				return AjaxResult.errorInstance("请先登录");
			}
			
			String city = user.getCity();
			*/
			SolrQuery query = new SolrQuery("name:"+city);
			
			QueryResponse resp = solrClient.query(query);
			SolrDocumentList docLise = resp.getResults();
			if (docLise.isEmpty()) {
				return AjaxResult.errorInstance("查询不到该城市");
			}
			SolrDocument doc = docLise.get(0);
			String cityId =  (String) doc.get("id");
			
			//根据城市的id查询这个城市Id的地区
			SolrQuery queryArea = new SolrQuery("parent_id:"+cityId);
			
			QueryResponse resp2 = solrClient.query(queryArea);
			SolrDocumentList lise = resp2.getResults();
			if (lise.isEmpty()) {
				return AjaxResult.successInstance(areaList.add("无"));
			}
			for(SolrDocument doc2:lise) {
				areaList.add(doc2.get("name"));
			}
			
			return AjaxResult.successInstance(areaList);
		} finally {
			solrClient.close();
		}
	}	
	
	//创建的格式 userId=hotelId=roomId=checkInDate=checkOutDate:date=userId=hotelId=roomId=checkInDate=checkOutDate=0
	@RequestMapping(value="/userOrder",method=RequestMethod.GET)
	public ModelAndView userOrder(HttpServletRequest req,Integer curr) throws ParseException {
		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			return new ModelAndView("redirect:/user/login");
		}
		if (curr == null ) {
			curr = 1;
		}
		ModelAndView modelAndView = new ModelAndView("user/userOrder");
		PageInfo<Order> orderList = orderService.selectPage(curr, 4,user.getId());
		modelAndView.addObject("pageInfo", orderList);
		modelAndView.addObject("orderList", orderList.getList());
		List<Room> roomList = new ArrayList<>();
		List<Hotel> hotelList = new ArrayList<>();
		//todo:查出酒店和房间的名字
		for(Order ord:orderList.getList()) {
			Room room = roomService.selectOne(ord.getRoomId());
			roomList.add(room);
			
			Hotel hotel = hotelService.selectOne(ord.getHotelId());
			hotelList.add(hotel);
			
			if (ord.getOrderType() == null) {
				ord.setOrderType("未付款");
			}
			//判断是否评价过
			Comment comment = new Comment();
			comment.setUserId(user.getId());
			comment.setCheckInDate(ord.getCheckInDate());
			comment.setCheckOutDate(ord.getCheckInDate());
			comment.setHotelId(ord.getHotelId());
			comment.setRoomId(ord.getRoomId());
			
			if (commentService.isExisted(comment)) {
				ord.setCommented(true);
			}else {
				ord.setCommented(false);
			}
		}
		
		
		
		modelAndView.addObject("roomList", roomList);
		modelAndView.addObject("hotelList", hotelList);
		return modelAndView;
	}
	
	//提供一个方法判断订单状态（已经废弃）
	@Deprecated
	private Map<String,String> orderType(List<Order> orderList){
		Map<String,String> orderType = new HashMap<>();
		//orderId type
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(Order o:orderList) {
			StringBuilder key = new StringBuilder();
			key.append(o.getUserId()).append("=").append(o.getHotelId()).append("=")
			.append(o.getRoomId()).append("=").append(format.format(o.getCheckInDate())).append("=")
			.append(format.format(o.getCheckOutDate()));
			
			if (o.getPayOrNot() == true) {
				orderType.put(key.toString(),"已付款");
				continue;
			}
			
			String value = JedisUtils.get(key.toString());
			if (value == null) {
				orderType.put(key.toString(),"已失效");
			}else {
				orderType.put(key.toString(),"未付款-"+o.getId());
			}
		}
		
		//未付款和已失效的判断
		for(Entry<String, String> type:orderType.entrySet()) {
			for(Entry<String, String> type2:orderType.entrySet()) {
				if (type.getKey().equals(type2.getKey())&&type.getValue().equals("未付款")) {
					String value = type.getKey();
					String[] typeAndIds = value.split("-");
					Date type1Date = orderService.selectOne(Long.parseLong(typeAndIds[0])).getCreateDate();
					
					String value2 = type.getKey();
					String[] typeAndIds2 = value2.split("-");
					Date type2Date = orderService.selectOne(Long.parseLong(typeAndIds2[0])).getCreateDate();
					
					if (type1Date.getTime()<type2Date.getTime()) {
						type2.setValue("已经失效");
					}
				}
			}	
		}
		
		return orderType;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value="/comment",method=RequestMethod.GET)
	public ModelAndView commentPage(Long hotelId,Long roomId,Date checkInDate,Date checkOutDate) {
		ModelAndView modelAndView = new ModelAndView("/user/comment");
		modelAndView.addObject("hotelId", hotelId);
		modelAndView.addObject("roomId",roomId);
		modelAndView.addObject("checkInDate",checkInDate);
		modelAndView.addObject("checkOutDate", checkOutDate);
		return modelAndView;
	}
	
	@RequestMapping(value="/comment",method=RequestMethod.POST)
	public ModelAndView commentSubmit(Order order,String comment,HttpServletResponse resp,HttpServletRequest req) throws IOException {
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		if (comment == null) {
			resp.getWriter().print("<script type='text/javascript'>alert('评论不能为空');history.go(-1);</script>");
			return null;
		}
		//判断这个用户能否评价这个酒店
		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			resp.getWriter().print("<script type='text/javascript'>alert('请点击下方登录');history.go(-1);</script>");
			return null;
		}
		
		order.setUserId(user.getId());
		List<Boolean> list = orderService.selectPayOrNot(order);
		boolean flag = false;
		for(Boolean b : list) {
			if (b) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			resp.getWriter().print("<script type='text/javascript'>alert('你不能评价该酒店');history.go(-1);</script>");
			return null;
		}
		
		Comment pojo = new Comment();
		pojo.setComment(comment);
		pojo.setCreateTime(new Date());
		pojo.setHotelId(order.getHotelId());
		pojo.setPhoneNum(user.getPhoneNum());
		pojo.setRoomId(order.getRoomId());
		Room room = roomService.selectOne(order.getRoomId());
		pojo.setRoomName(room.getRoomName());
		pojo.setUserId(user.getId());
		pojo.setCheckInDate(order.getCheckInDate());
		pojo.setCheckOutDate(order.getCheckOutDate());
		commentService.insert(pojo);
		
		ModelAndView modelAndView = new ModelAndView("redirect:/user/userOrder");
		return modelAndView;
	}
}

package top.lapa.web.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import redis.clients.jedis.Jedis;
import top.lsp.util.JedisUtils;
import top.lspa.pojo.User;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	//高并发情况下有Bug由于用的人较少，所以先不修改了
	@RequestMapping(value="/order")
	public ModelAndView orderPage(String hotelId,String roomId,String checkInDate,String checkOutDate,HttpServletResponse resp,HttpServletRequest req) throws IOException {
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
//	    JedisUtils.getLock();
	    Jedis jedis = JedisUtils.getJedis();
//	    while (!jedis.exists("lock")) {
//			
//		}
	    Set<String> set = jedis.keys(sb.toString()); 
	    String value = null;
	    if (set.size()>0) {
    		for(String str:set) {
    			value = str;
    		}
	    }
		if (value!=null) {
			resp.getWriter().println("<script type='text/javascript'>alert('手速慢了，刚被预定了');history.go(-1);</script>");
//			jedis.del("lock");
			jedis.close();
			return null;
		}else {
			StringBuilder jValue = new StringBuilder();
			SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd ");
			jValue.append(formatter.format(new Date())).append("=").append(sb.toString()).append("=0");
			String key = sb.toString().replaceAll("\\*", String.valueOf(user.getId()));
			
			JedisUtils.setex(key, 60*10, jValue.toString());
//			jedis.del("lock");
		}
//		jedis.del("lock");
		jedis.close();
		ModelAndView modelAndView = new ModelAndView("room/order");
		return modelAndView;
	}
}

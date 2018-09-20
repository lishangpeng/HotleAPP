package top.lapa.web.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lsp.util.CommonUtils;
import top.lsp.util.ImageCodeUtils;
import top.lspa.pojo.User;
import top.lspa.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
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
		
		return new ModelAndView("user/login");
	}
}
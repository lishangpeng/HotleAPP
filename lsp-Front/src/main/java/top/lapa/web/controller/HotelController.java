package top.lapa.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lspa.pojo.Hotel;
import top.lspa.pojo.User;
import top.lspa.service.HotelService;

@Controller
@RequestMapping("/hotel")
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public ModelAndView hotelPage() {
		ModelAndView modelAndView = new ModelAndView("hotel/hotel");
		List<Hotel> hotelList = hotelService.selectList();
		modelAndView.addObject("hotelList", hotelList);
		return modelAndView;
	}
	
	
	@RequestMapping(value="/cityList",method=RequestMethod.GET)
	public ModelAndView cityList(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		
		if (user!=null) {
			ModelAndView modelAndView = new ModelAndView("CityList");
			return modelAndView;
		}else {
			return new ModelAndView("user/login");
		}
	}
}

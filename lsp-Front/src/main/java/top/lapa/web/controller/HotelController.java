package top.lapa.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lspa.pojo.Hotel;
import top.lspa.service.HotelService;

@Controller
@RequestMapping("/hotel")
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public ModelAndView hotelPage() {
		ModelAndView modelAndView = new ModelAndView("hotel");
		List<Hotel> hotelList = hotelService.selectList();
		modelAndView.addObject("hotelList", hotelList);
		return modelAndView;
	}
}

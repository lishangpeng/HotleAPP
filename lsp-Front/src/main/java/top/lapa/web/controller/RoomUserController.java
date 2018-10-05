package top.lapa.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/roomUser")
public class RoomUserController {
	@RequestMapping("/pay")
	public ModelAndView order() {
		ModelAndView modelAndView = new ModelAndView("room/pay");
		return modelAndView;
	}
}

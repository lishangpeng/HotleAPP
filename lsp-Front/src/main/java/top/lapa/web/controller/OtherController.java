package top.lapa.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lsp.util.ImageCodeUtils;

@Controller
public class OtherController {
	
	@RequestMapping("/")
	public ModelAndView index() {
		ModelAndView modelAndView = new ModelAndView("index");
		return modelAndView;
	}
	
	@RequestMapping("/imageCode")
	public void ImageCode(HttpServletRequest req,HttpServletResponse resp) {
		
		ImageCodeUtils.sendImageCode(req.getSession(), resp);
		
	}
	
	
}

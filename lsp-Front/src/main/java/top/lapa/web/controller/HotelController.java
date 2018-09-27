package top.lapa.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lspa.pojo.Hotel;
import top.lspa.pojo.Room;
import top.lspa.pojo.User;
import top.lspa.service.HotelService;
import top.lspa.service.RoomService;

@Controller
@RequestMapping("/hotel")
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private RoomService roomService;
	
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
	
	@RequestMapping(value="/hotelList",method=RequestMethod.GET)
	public ModelAndView hotelList(String checkInDate,String checkOutDate,String cityArea,String city) {
		ModelAndView modelAndView = new ModelAndView("hotel/hotelList");
		//todo:查询出所有的该地区的hotel
		Hotel hotel = new Hotel();
		if ("没有下级区域".equals(cityArea)) {
			cityArea = city;
			city = null;
		}
		if ("全部".equals(cityArea)) {
			cityArea = null;
		}
		if (city!=null) {
			city = "%"+city+"%";
		}
		if (cityArea!=null) {
			cityArea = "%"+cityArea+"%";
		}
		hotel.setCity(city);
		hotel.setArea(cityArea);
		List<Hotel> hotelList = hotelService.selectList(hotel);
		modelAndView.addObject("hotelList", hotelList);
		modelAndView.addObject("checkInDate", checkInDate);
		modelAndView.addObject("checkOutDate", checkOutDate);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/detail",method=RequestMethod.GET)
	public ModelAndView hotelDetail(String checkInDate,String checkOutDate,Long hotelId) {
		ModelAndView modelAndView = new ModelAndView("hotel/hotelDetail");
		modelAndView.addObject("checkInDate", checkInDate);
		modelAndView.addObject("checkOutDate", checkOutDate);
		Room room = new Room();
		room.setHotelId(hotelId);
		List<Room> roomList = roomService.selectList(room);
		modelAndView.addObject("roomList", roomList);
		
		Hotel hotel = hotelService.selectOne(hotelId);
		modelAndView.addObject("hotel", hotel);
		return modelAndView;
	}
}

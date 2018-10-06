package top.lapa.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import top.lspa.pojo.Hotel;
import top.lspa.pojo.Room;
import top.lspa.pojo.RoomResult;
import top.lspa.pojo.RoomUser;
import top.lspa.pojo.User;
import top.lspa.service.HotelService;
import top.lspa.service.RoomService;
import top.lspa.service.RoomUserService;

@Controller
@RequestMapping("/hotel")
public class HotelController {
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private RoomService roomService;
	
	@Autowired
	private RoomUserService roomUserService;
	
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
	
/*	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public @ResponseBody AjaxResult hotelTimeChange(String checkInDate,String checkOutDate,Long hotelId) {
		
	}*/
	
	@RequestMapping(value="/detail")
	public ModelAndView hotelDetail(String checkInDate,String checkOutDate,Long hotelId) throws ParseException {
		ModelAndView modelAndView = new ModelAndView("hotel/hotelDetail");
		if (checkInDate.length()>10) {
			checkInDate = checkInDate.substring(0, 10);
			checkOutDate = checkOutDate.substring(0, 10);
		}
		modelAndView.addObject("checkInDate", checkInDate);
		modelAndView.addObject("checkOutDate", checkOutDate);
		Room room = new Room();
		room.setHotelId(hotelId);
		List<Room> roomList = roomService.selectList(room);
		modelAndView.addObject("roomList", roomList);
		
		Hotel hotel = hotelService.selectOne(hotelId);
		modelAndView.addObject("hotel", hotel);
		
		//todo 判断是否为满房
		List<RoomResult> roomResultList = isRoomEmptyOrNot(roomList, checkInDate, checkOutDate);
		modelAndView.addObject("roomResultList", roomResultList);
		//todo String转化为Date并比较大小
/*		String pattern ="yyyy-MM-dd";//格式化日期格式
		SimpleDateFormat sf = new SimpleDateFormat(pattern);
		Date dateIn = sf.parse(checkInDate);//把时间格式化
		Date dateOut = sf.parse(checkOutDate);//把时间格式化
		*/
		return modelAndView;
	}
	
	/**
	 * 
	 * @param roomList
	 * @return List<RoomResult> 房间号和是否满人
	 * @throws ParseException 
	 */
	private List<RoomResult> isRoomEmptyOrNot(List<Room> roomList,String checkInDate,String checkOutDate) throws ParseException {
		List<RoomResult> roomResultList = new ArrayList<>();
		for(Room room:roomList) {
			Long roomId = room.getId();
			RoomUser roomUser = new RoomUser();
			roomUser.setRoomId(roomId);
			RoomResult roomResult = new RoomResult();
			List<RoomUser> roomUserList = roomUserService.selectList(roomUser);
			User user  = roomUserService.selectSecondOneByFirstId(roomId);
			if (user==null) {
				roomResult.setHavePeople(true);
				roomResult.setRoomId(roomId);
			}else {
				
				Date maxOut = getMaxOutDate(roomUserList);
				Date minIn = getMinInDate(roomUserList);
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date dateUserin = formatter.parse(checkInDate);
				Date dateUserout = formatter.parse(checkOutDate);
				
				if ((dateUserin.getTime()>maxOut.getTime())||(dateUserout.getTime()<minIn.getTime())) {
					roomResult.setHavePeople(true);
					roomResult.setRoomId(roomId);
				}else {
					roomResult.setHavePeople(false);
					roomResult.setRoomId(roomId);
				}
			}
			roomResultList.add(roomResult);
		}
		return roomResultList;
	}
	
	private Date getMaxOutDate(List<RoomUser> roomUserList) {
		Collections.sort(roomUserList, new Comparator<RoomUser>() {
			@Override
			public int compare(RoomUser o1, RoomUser o2) {
				if (o1.getCheckOutDate().getTime() > o2.getCheckOutDate().getTime()) {
					return -1;
				}else if(o1.getCheckOutDate().getTime() < o2.getCheckOutDate().getTime()) {
					return 1;
				}else {
					return 0;
				}
			}
		});
		return  roomUserList.get(0).getCheckOutDate();
	}
	
	private Date getMinInDate(List<RoomUser> roomUserList) {
		Collections.sort(roomUserList, new Comparator<RoomUser>() {
			@Override
			public int compare(RoomUser o1, RoomUser o2) {
				if (o1.getCheckInDate().getTime() > o2.getCheckInDate().getTime()) {
					return 1;
				}else if(o1.getCheckInDate().getTime() < o2.getCheckInDate().getTime()) {
					return -1;
				}else {
					return 0;
				}
			}
		});
		return roomUserList.get(0).getCheckInDate();
	}
	
	@RequestMapping("/nearHotel")
	public ModelAndView nearHotel() {
		return new ModelAndView("map");
	}
}

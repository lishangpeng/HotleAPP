package top.lspa.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import top.lspa.pojo.Hotel;
import top.lspa.service.HotelService;


public class HotelTest {

    private ApplicationContext applicationContext;
    private HotelService hotelService;

    @Before
    public void init() {
        applicationContext = new ClassPathXmlApplicationContext("/beans.xml");
        hotelService = applicationContext.getBean(HotelService.class);
    }
    

    @Test
    public void testInsertIsExistedSelectOneDelete() {
    	
    	List<Hotel> hotelList = hotelService.selectList();
    }
}

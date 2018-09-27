package top.lspa.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import top.lspa.pojo.Room;
import top.lspa.service.RoomService;

public class RoomTest {
    private ApplicationContext applicationContext;
    private RoomService roomService;

    @Before
    public void init() {
        applicationContext = new ClassPathXmlApplicationContext("/beans.xml");
        roomService = applicationContext.getBean(RoomService.class);
    }
    

    @Test
    public void testInsertIsExistedSelectOneDelete() {
    	
    	List<Room> roomList = roomService.selectList();
    }
}

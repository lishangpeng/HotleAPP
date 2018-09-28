package top.lspa.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import top.lspa.pojo.Room;
import top.lspa.service.RoomUserService;

public class RoomUserTest {

    private ApplicationContext applicationContext;
    private RoomUserService roomUserService;

    @Before
    public void init() {
        applicationContext = new ClassPathXmlApplicationContext("/beans.xml");
        roomUserService = applicationContext.getBean(RoomUserService.class);
    }
    

    @Test
    public void testInsertIsExistedSelectOneDelete() {
    	
    	List<Room> roomList = roomUserService.selectFirstListBySecondId(1L);
    }
}

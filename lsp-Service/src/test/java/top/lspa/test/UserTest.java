package top.lspa.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import top.lspa.pojo.User;
import top.lspa.service.UserService;

public class UserTest {
	
    private ApplicationContext applicationContext;
    private UserService userService;

    @Before
    public void init() {
        applicationContext = new ClassPathXmlApplicationContext("/beans.xml");
        userService = applicationContext.getBean(UserService.class);
    }
    

    @Test
    public void testInsertIsExistedSelectOneDelete() {
    	
    	List<User> hotelList = userService.selectList();
    }
}

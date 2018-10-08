package top.lspa.test;

import java.util.Date;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import top.lspa.pojo.Order;
import top.lspa.pojo.Room;
import top.lspa.service.OrderService;
import top.lspa.service.RoomService;

public class OrderTest {
    private ApplicationContext applicationContext;
    private OrderService orderService;

    @Before
    public void init() {
        applicationContext = new ClassPathXmlApplicationContext("/beans.xml");
        orderService = applicationContext.getBean(OrderService.class);
    }
    

    @Test
    public void testInsertIsExistedSelectOneDelete() {
    	Order order = new Order();
    	order.setCheckInDate(new Date());
    	order.setCheckOutDate(new Date());
    	order.setUserId(1L);
    	Boolean b = orderService.selectPayOrNot(order);
    	System.out.println(b);
    }
}

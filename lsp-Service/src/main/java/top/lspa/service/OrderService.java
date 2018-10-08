package top.lspa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.lspa.mapper.OrderMapper;
import top.lspa.pojo.Order;

@Service
public class OrderService extends BaseService<Order>{
	
	@Autowired
	private OrderMapper orderMapper;
	public Boolean selectPayOrNot(Order order) {
		Boolean bo =  orderMapper.selectPayOrNot(order);
		if (bo == null) {
			bo = false;
		}
		return bo;
	}
}

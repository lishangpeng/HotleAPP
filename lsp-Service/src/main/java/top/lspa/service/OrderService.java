package top.lspa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.lspa.mapper.OrderMapper;
import top.lspa.pojo.Order;

@Service
public class OrderService extends BaseService<Order>{
	
	@Autowired
	private OrderMapper orderMapper;
	public List<Boolean> selectPayOrNot(Order order) {
		List<Boolean> bos =  orderMapper.selectPayOrNot(order);
		for(Boolean bo:bos) {
			if (bo == null) {
				bo = false;
			}
		}
		return bos;
	}
}

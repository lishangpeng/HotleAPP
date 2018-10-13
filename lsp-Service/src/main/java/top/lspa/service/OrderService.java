package top.lspa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

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
	
	public PageInfo<Order> selectPage(int curr,int pageSize,Long userId){
		Order order = new Order();
		order.setUserId(userId);
		PageHelper.startPage(curr, pageSize);
		PageHelper.orderBy("createDate desc");
		List<Order> orderList = orderMapper.select(order);
		
		return new PageInfo<Order>(orderList);
	}
	
	public int updateOrderType(Order type) {
		return orderMapper.updateOrderType(type);
	}
}

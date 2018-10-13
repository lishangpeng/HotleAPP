package top.lspa.mapper;

import java.util.List;

import top.lspa.pojo.Order;

public interface OrderMapper extends IMapper<Order>{
	public List<Boolean> selectPayOrNot(Order order);
	
	public int updateOrderType(Order order);
}

package top.lspa.mapper;

import top.lspa.pojo.Order;

public interface OrderMapper extends IMapper<Order>{
	public Boolean selectPayOrNot(Order order);
}

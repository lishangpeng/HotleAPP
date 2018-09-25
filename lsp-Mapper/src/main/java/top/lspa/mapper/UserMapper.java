package top.lspa.mapper;

import top.lspa.pojo.User;

public interface UserMapper extends IMapper<User>{
	public int updateCity(User user);
}

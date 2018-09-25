package top.lspa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.lspa.mapper.UserMapper;
import top.lspa.pojo.User;

@Service
public class UserService extends BaseService<User>{
	
	@Autowired
	private UserMapper userMapper;
	
	public int updateCity(User user) {
		return userMapper.updateCity(user);
	}
}

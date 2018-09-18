package top.lspa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import top.lspa.mapper.IMapper;

public class BaseService<T> {
	@Autowired
	private IMapper<T> mapper;
	
	public List<T> selectList(T pojo) {
		return mapper.select(pojo);
	}
	
	public List<T> selectList() {
		return mapper.select(null);
	}
}

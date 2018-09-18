package top.lspa.mapper;

import java.util.List;

public interface IMapper<T> {
	
	public int insert(T pojo);
	
	public int update(T pojo);
	
	public int delete(Long id );
	
	List<T> select(T pojo);
}

package top.lspa.service;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import top.lspa.mapper.IMapper;

public class BaseService<T> {
	@Autowired
	private IMapper<T> mapper;
	
	@SuppressWarnings("all")
	protected T createInstanceAndSetIdOfFirstGeneric(Long id) {
		if (id == null) {
			throw new RuntimeException("id不能为null");
		}
		
		ParameterizedType type = (ParameterizedType) getClass().getGenericSuperclass();
		Class tClazz = (Class) type.getActualTypeArguments()[0];
		try {
			T t = (T) tClazz.newInstance();
			tClazz.getDeclaredMethod("setId", Long.class).invoke(t, id);
			return t;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	public List<T> selectList(T pojo) {
		return mapper.select(pojo);
	}
	
	public List<T> selectList() {
		return mapper.select(null);
	}
	
	public int insert(T pojo) {
		return mapper.insert(pojo);
	}
	
	public T selectOne(T pojo) {
		List<T> list = mapper.select(pojo);
		if (list==null||list.size()==0) {
			return null;
		}
		if (list.size()>1) {
			throw new RuntimeException("selectOne方法查询出多个结果");
		}
		
		return list.get(0);
	}
	
	public T selectOne(Long id) {
		T pojo = createInstanceAndSetIdOfFirstGeneric(id);
		
		List<T> list = mapper.select(pojo);
		if (list == null || list.size() == 0) {
			return null;
		}
		if (list.size()>1) {
			throw new RuntimeException("找到不止一个结果");
		}
		return list.get(0);
	}
	
	public int delete(Long id) {
		return mapper.delete(id);
	}
	
    public PageInfo<T> page(int pageNum, int pageSize, T pojo) {
        PageHelper.startPage(pageNum, pageSize);//注意pageNum表示页码，从1开始
        List<T> list = mapper.select(pojo);//正常执行自己的Mapper的查询方法
        return new PageInfo<T>(list);
    }

    public PageInfo<T> page(int pageNum, int pageSize, T pojo, String orderBy) {
        PageHelper.startPage(pageNum, pageSize);//注意pageNum表示页码，从1开始
        PageHelper.orderBy(orderBy);
        List<T> list = mapper.select(pojo);//正常执行自己的Mapper的查询方法
        return new PageInfo<T>(list);
    }

    //判断是否已经存在
    public boolean isExisted(T pojo) {
        List<T> list = mapper.select(pojo);
        return list != null && list.size() > 0;
    }
}

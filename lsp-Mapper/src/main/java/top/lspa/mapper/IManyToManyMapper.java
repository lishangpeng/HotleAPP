package top.lspa.mapper;

import java.util.List;

public interface IManyToManyMapper<T,F,S> extends IMapper<T> {

    public int deleteByFirstId(Long firstId);

    public int deleteBySecondId(Long secondId);

    public List<F> selectFirstListBySecondId(Long secondId);

    public List<S> selectSecondListByFirstId(Long firstId);
    

}

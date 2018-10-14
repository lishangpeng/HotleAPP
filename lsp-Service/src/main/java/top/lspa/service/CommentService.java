package top.lspa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import top.lspa.pojo.Comment;

@Service
public class CommentService extends BaseService<Comment>{
	
	public PageInfo<Comment> page(Integer curr,int pageSize,Long hotelId){
		PageHelper.orderBy("createTime desc");
		PageHelper.startPage(curr, pageSize);
		Comment comment = new Comment();
		comment.setHotelId(hotelId);
		List<Comment> commentList = selectList(comment);
		return new PageInfo<Comment>(commentList);
	}
}

package top.lapa.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.HttpSolrClient.Builder;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import top.lsp.util.AjaxResult;
import top.lsp.util.CommonUtils;
import top.lsp.util.ImageCodeUtils;
import top.lspa.pojo.User;
import top.lspa.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public ModelAndView registerPage() {
		ModelAndView modelAndView = new ModelAndView("user/register");
		return modelAndView;
	}
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public ModelAndView registerSubmit(User user,String rePassword,String yzm,HttpServletRequest req) {
		
		//39.903740,116.397827  北京天安门的经纬度
		ModelAndView modelAndView = new ModelAndView("user/register");
		if (CommonUtils.isEmpty(user.getCity())) {
			user.setCity("北京");
		}
		if (user.getLat() == null||user.getLng() == null) {
			user.setLat(39.903740);
			user.setLng(116.397827);
		}
		
		if (!CommonUtils.isPhone(user.getPhoneNum())) {
			modelAndView.addObject("message", "不是一个手机号码");
			return modelAndView;
		}
		
		if (!CommonUtils.isIdCard(user.getIdCard())) {
			modelAndView.addObject("message", "不是一个身份证");
			return modelAndView;
		}
		
		if (!CommonUtils.isLengthEnough(user.getPassword(), 6)) {
			modelAndView.addObject("message", "密码长度太短");
			return modelAndView;
		}
		
		if (!ImageCodeUtils.checkImageCode(req.getSession(), yzm)) {
			modelAndView.addObject("message", "验证码不一致");
			return modelAndView;
		}
		
		if (!user.getPassword().equals(rePassword)) {
			modelAndView.addObject("message", "两次密码不一致");
			return modelAndView;
		}
		
		//todo:唯一性判断：
		User userPhoneNum = new User();
		userPhoneNum.setPhoneNum(user.getPhoneNum());
		if (!CommonUtils.isEmpty(userService.selectList(userPhoneNum))) {
			modelAndView.addObject("message", "手机号码已经被注册");
			return modelAndView;
		}
		
		User useridCard = new User();
		useridCard.setIdCard(user.getIdCard());
		if (!CommonUtils.isEmpty(userService.selectList(useridCard))) {
			modelAndView.addObject("message", "身份证号码已经被注册");
			return modelAndView;
		}
		//todo md5加密插入
		
		String salt = UUID.randomUUID().toString();
		String password = CommonUtils.calculateMD5(salt+user.getPassword());
		
		user.setPassword(password);
		user.setPasswordSalt(salt);
		userService.insert(user);
		
		return new ModelAndView("redirect:/user/login");
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView modelAndView = new ModelAndView("user/login");
		return modelAndView;
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public ModelAndView loginSubmit(String info,String password,HttpServletRequest req) {
		
		ModelAndView modelAndView = new ModelAndView("user/login");
		User user = new User();
		if (!CommonUtils.isPhone(info)&&!CommonUtils.isIdCard(info)) {
			modelAndView.addObject("message", "帐号或者密码错误");
			return modelAndView;
		}
		if (CommonUtils.isPhone(info)) {
			user.setPhoneNum(info);
		}
		if (CommonUtils.isIdCard(info)) {
			user.setIdCard(info);
		}
		
		user = userService.selectOne(user);
		if (user!=null) {
			
			if (user.getPassword().equals(CommonUtils.calculateMD5(user.getPasswordSalt()+password))) {
				req.getSession().setAttribute("user", user);
				return new ModelAndView("redirect:/");
			}else {
				modelAndView.addObject("message", "账号或者密码错误");
				return modelAndView;
			}
		}else {
			modelAndView.addObject("message", "此用户还未注册");
			return modelAndView;
		}
	}
	
	//使用sorl 查询
	@RequestMapping("/editCity")
	public @ResponseBody AjaxResult editCity(String cityChange,HttpServletRequest req) throws SolrServerException, IOException {

		HttpSolrClient.Builder bulider = new Builder("http://localhost:8983/solr/region");
		HttpSolrClient solrClient = bulider.build();
		try {
			if (cityChange.isEmpty()) {
				return AjaxResult.errorInstance("城市不能为空");
			}
			SolrQuery query = new SolrQuery("name:"+cityChange);
			
			QueryResponse resp = solrClient.query(query);
			SolrDocumentList docLise = resp.getResults();
			if (docLise.isEmpty()) {
				return AjaxResult.errorInstance("查询不到该城市");
			}
			SolrDocument doc = docLise.get(0);
			List<String> recity =  (List<String>) doc.get("name");
			
			//todo  直接帮第一个结果给用户更改city
/*			User user = (User) req.getSession().getAttribute("user");
			if (user==null) {
				return AjaxResult.errorInstance("请先登录");
			}
			user.setCity(recity.get(0));
			userService.updateCity(user);*/
			return AjaxResult.successInstance(recity.get(0));
		} finally {
			solrClient.close();
		}
	}
	
	@RequestMapping("/changeArea")
	public @ResponseBody AjaxResult changeArea(HttpServletRequest req,String city) throws SolrServerException, IOException {
		
		HttpSolrClient.Builder bulider = new Builder("http://localhost:8983/solr/region");
		HttpSolrClient solrClient = bulider.build();

		try {
			//todo:随着城市改变地区
			List<Object> areaList = new ArrayList<>();
/*			//根据城市查询城市Id
			User user = (User) req.getSession().getAttribute("user");
			if (user==null) {
				return AjaxResult.errorInstance("请先登录");
			}
			
			String city = user.getCity();
			*/
			SolrQuery query = new SolrQuery("name:"+city);
			
			QueryResponse resp = solrClient.query(query);
			SolrDocumentList docLise = resp.getResults();
			if (docLise.isEmpty()) {
				return AjaxResult.errorInstance("查询不到该城市");
			}
			SolrDocument doc = docLise.get(0);
			String cityId =  (String) doc.get("id");
			
			//根据城市的id查询这个城市Id的地区
			SolrQuery queryArea = new SolrQuery("parent_id:"+cityId);
			
			QueryResponse resp2 = solrClient.query(queryArea);
			SolrDocumentList lise = resp2.getResults();
			if (lise.isEmpty()) {
				return AjaxResult.successInstance(areaList.add("无"));
			}
			for(SolrDocument doc2:lise) {
				areaList.add(doc2.get("name"));
			}
			
			return AjaxResult.successInstance(areaList);
		} finally {
			solrClient.close();
		}
	}
}

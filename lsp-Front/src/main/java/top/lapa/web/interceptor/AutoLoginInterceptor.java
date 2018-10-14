package top.lapa.web.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import top.lsp.util.CommonUtils;
import top.lspa.pojo.User;
import top.lspa.service.UserService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private UserService userService;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		User user = (User) request.getSession().getAttribute("user");
		if (user!=null) {
			return true;
		}
		
		Cookie loginNameCookie = WebUtils.getCookie(request, "loginNameCookie");
		Cookie passwordCookie = WebUtils.getCookie(request, "passwordCookie");
		if (loginNameCookie==null || passwordCookie==null) {
			return true;
		}
		
		String loginName = loginNameCookie.getValue();
		String password = passwordCookie.getValue();
		user = new User();
		if (CommonUtils.isIdCard(loginName)) {
			user.setIdCard(loginName);
		}else {
			user.setPhoneNum(loginName);
		}
		
		//无论成功失败都返回true
		try {
			user = userService.selectOne(user);
			if (user.getPassword().equals(password)) {
				request.getSession().setAttribute("user", user);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return true;
		
	}
}

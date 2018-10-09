package top.lapa.web.aop;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.validation.BindingResult;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import top.lsp.util.JsonUtils;
import top.lspa.pojo.User;

@Aspect
public class LogAspect {
	private static final Logger logger = LogManager.getLogger("用户操作日子");
	
	@Pointcut("@annotation(org.springframework.web.bind.annotation.RequestMapping)")
	public void controller(){
		
	}
	
	@Before("controller()")
	public void log(JoinPoint joinPoint) {
		
		if (!logger.isInfoEnabled()) {
			return;
		}
		
		HttpServletRequest request =  ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		User user = (User) request.getSession().getAttribute("user");
		Long userId = null;
		if (user!=null) {
			userId = user.getId();
		}
		
		Object[] args = joinPoint.getArgs();
		if (args!=null && args.length>0) {
			for(int i=0;i<args.length;i++) {
				if (args[i] instanceof HttpServletRequest) {
					args[i] = "request对象";
				}else if(args[i] instanceof HttpServletResponse) {
					args[i] = "response对象";
				}else if (args[i] instanceof MultipartFile) {
					args[i] = "MultipartFile对象";
				}else if (args[i] instanceof BindingResult) {
					args[i] = "BindingResult对象";
				}
			}
		}
		logger.info("用户id:{},方法签名:{},方法参数列表:{}",userId,joinPoint.getSignature(),JsonUtils.toJson(args));

	}
}

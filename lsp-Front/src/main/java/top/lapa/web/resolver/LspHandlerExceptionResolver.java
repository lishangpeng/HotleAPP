package top.lapa.web.resolver;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import top.lsp.util.AjaxResult;
import top.lsp.util.JsonUtils;

@Component
public class LspHandlerExceptionResolver implements HandlerExceptionResolver {
	private static final Logger logger = LogManager.getLogger(LspHandlerExceptionResolver.class);

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		logger.error("服务器出错了", ex);
		if (request.getHeader("X-Requested-With") != null) {

			AjaxResult ajaxResult = AjaxResult.errorInstance("服务器出错了");
			try {
				response.getWriter().println(JsonUtils.toJson(ajaxResult));
			} catch (IOException e) {
				logger.error("ajax发送错误信息的时候出错", e);
			}

			return new ModelAndView("");
		} else {
			return new ModelAndView("500");
		}
	}

}

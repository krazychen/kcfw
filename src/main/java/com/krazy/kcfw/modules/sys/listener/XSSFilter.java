package com.krazy.kcfw.modules.sys.listener;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;
import org.springframework.util.PatternMatchUtils;

import com.krazy.kcfw.common.utils.StringUtils;

 
/**
 *
 * <ol>XSS注入拦截
 * <li>{@link  }</li>
 * </ol>
 *
 */
public class XSSFilter implements Filter {

	/**
	 * 需要排除的页面
	 */
	private String excludedPages;

	private String[] excludedPageArray;
	
	@SuppressWarnings("unused")
	private FilterConfig filterConfig;

	public void destroy() {
		this.filterConfig = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		boolean isExcludedPage = false;

		HttpServletRequest request2 = (HttpServletRequest) request;
		//判断是否需要XSS攻击防护
		isExcludedPage = isMatchUrl(excludedPageArray,   request2) ;
		
		if (isExcludedPage) {
			chain.doFilter(request, response);
		} else {
			chain.doFilter(new XssRequestWrapper(request2), response);
		}

	}

	/**
	 * 自定义过滤规则
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		excludedPages = filterConfig.getInitParameter("excludedPages");
		excludedPageArray = new String[] {};
		if (StringUtils.isNotEmpty(excludedPages)) {
			excludedPageArray = excludedPages.replaceAll("[\\s]", "")
					.split(",");
		}
	}
  /**
	 * URL是否符合规则列表
	 * @param patterns
	 * @param request
	 * @return
	 */
   public static boolean isMatchUrl(String[] patterns,	HttpServletRequest request) {
		String ctx_path = request.getContextPath();
		String request_uri = request.getRequestURI();
		String action = request_uri.substring(ctx_path.length()).replaceAll("//", "/");
		return PatternMatchUtils.simpleMatch(patterns, action);
	}

	/**
	 * 
	 * <ol>装饰器模式加强request处理
	 * <li>{@link  }</li>
	 * 
	 * </ol>
	 * @see
	 * @author wanghui 
	 * @since 1.0
	 * @2016年3月14日
	 *
	 */
	static class XssRequestWrapper extends HttpServletRequestWrapper {

		private static Policy policy = null;

		static {
			try {
				policy = Policy.getInstance( XssRequestWrapper.class.getClassLoader()
						.getResourceAsStream("antisamy-anythinggoes-1.4.4.xml"));
			} catch (PolicyException e) {
				 
			}
		}

		public XssRequestWrapper(HttpServletRequest request) {
			super(request);
		}

		@Override
		@SuppressWarnings("rawtypes")
		public Map<String, String[]> getParameterMap() {
			Map<String, String[]> request_map = super.getParameterMap();
			Iterator iterator = request_map.entrySet().iterator();
			while (iterator.hasNext()) {
				Map.Entry me = (Map.Entry) iterator.next();
				String[] values = (String[]) me.getValue();
				for (int i = 0; i < values.length; i++) {
					values[i] = xssClean(values[i]);
				}
			}
			return request_map;
		}

		@Override
		public String[] getParameterValues(String paramString) {
			String[] arrayOfString1 = super.getParameterValues(paramString);
			if (arrayOfString1 == null)
				return null;
			int i = arrayOfString1.length;
			String[] arrayOfString2 = new String[i];
			for (int j = 0; j < i; j++)
				arrayOfString2[j] = xssClean(arrayOfString1[j]);
			return arrayOfString2;
		}

		@Override
		public String getParameter(String paramString) {
			String str = super.getParameter(paramString);
			if (str == null)
				return null;
			return xssClean(str);
		}

		@Override
		public String getHeader(String paramString) {
			String str = super.getHeader(paramString);
			if (str == null)
				return null;
			return xssClean(str);
		}

		private String xssClean(String value) {
			AntiSamy antiSamy = new AntiSamy();
			try {
				// CleanResults cr = antiSamy.scan(dirtyInput, policyFilePath);
				final CleanResults cr = antiSamy.scan(value, policy);
				// 安全的HTML输出
				return cr.getCleanHTML() ;
			} catch (ScanException e) {
			} catch (PolicyException e) {
			}
			return value;
		}

	}

}
package com.krazy.kcfw.modules.sys.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;

public class CustomLogonUrl extends AccessControlFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request,
			ServletResponse response) throws Exception {
		// TODO Auto-generated method stub获取当前网页地址

        HttpServletRequest httpServletRequest = (HttpServletRequest) request;

        httpServletRequest.getRequestURI();

        Subject subject = getSubject(request, response);

        if(!subject.isAuthenticated() && !subject.isRemembered()) {

            WebUtils.issueRedirect(request,response, getLoginUrl());

            return false;

        }

        return true;

    }

}

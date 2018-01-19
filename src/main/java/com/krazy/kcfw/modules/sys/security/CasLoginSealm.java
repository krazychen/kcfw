package com.krazy.kcfw.modules.sys.security;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cas.CasAuthenticationException;
import org.apache.shiro.cas.CasRealm;
import org.apache.shiro.cas.CasToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.util.StringUtils;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.jasig.cas.client.validation.Assertion;
import org.jasig.cas.client.validation.Cas20ServiceTicketValidator;
import org.jasig.cas.client.validation.TicketValidationException;
import org.jasig.cas.client.validation.TicketValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.utils.Encodes;
import com.krazy.kcfw.common.utils.SpringContextHolder;
import com.krazy.kcfw.common.web.Servlets;
import com.krazy.kcfw.modules.sys.entity.Menu;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.krazy.kcfw.modules.sys.service.SystemService;
import com.krazy.kcfw.modules.sys.utils.LogUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;


public class CasLoginSealm extends org.apache.shiro.cas.CasRealm {
	
	private static Logger log = LoggerFactory.getLogger(CasLoginSealm.class);
	private SystemService systemService;
	
	/**
	 * 获取系统业务对象
	 */
	public SystemService getSystemService() {
		if (systemService == null){
			systemService = SpringContextHolder.getBean(SystemService.class);
		}
		return systemService;
	}
	
	
	@Override  
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {  
		Principal principal = (Principal) getAvailablePrincipal(principals);
		// 获取当前已登录的用户
		if (!Global.TRUE.equals(Global.getConfig("user.multiAccountLogin"))){
			Collection<Session> sessions = getSystemService().getSessionDao().getActiveSessions(true, principal, UserUtils.getSession());
			if (sessions.size() > 0){
				// 如果是登录进来的，则踢出已在线用户
				if (UserUtils.getSubject().isAuthenticated()){
					for (Session session : sessions){
						getSystemService().getSessionDao().delete(session);
					}
				}
				// 记住我进来的，并且当前用户已登录，则退出当前用户提示信息。
				else{
					UserUtils.getSubject().logout();
					SecurityUtils.getSubject().logout();  
					throw new AuthenticationException("msg:账号已在其它地方登录，请重新登录。");
				}
			}
		}
		//User user = getSystemService().getUserByLoginName(principal.getLoginName());
		Object username =principals.getPrimaryPrincipal();
		log.debug("username +++++++++++++++++++++++++:"+username.toString());
		User user = UserUtils.getByLoginName(username.toString());
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			List<Menu> list = UserUtils.getMenuList();
			for (Menu menu : list){
				if (com.krazy.kcfw.common.utils.StringUtils.isNotBlank(menu.getPermission())){
					// 添加基于Permission的权限信息
					for (String permission : com.krazy.kcfw.common.utils.StringUtils.split(menu.getPermission(),",")){
						info.addStringPermission(permission);
					}
				}
				log.debug("menu +++++++++++++++++++++++++:"+menu.getName());
			}
			// 添加用户权限
			info.addStringPermission("user");
			// 添加用户角色信息
			for (Role role : user.getRoleList()){
				info.addRole(role.getEnname());
			}
			// 更新登录IP和时间
			getSystemService().updateUserLoginInfo(user);
			// 记录登录日志
			LogUtils.saveLog(Servlets.getRequest(), "系统登录");
			return info;
		} else {
			return null;
		}
		
        //String username = (String)principals.getPrimaryPrincipal();  //从这里可以从cas server获得认证通过的用户名，得到后我们可以根据用户名进行具体的授权  
       //也可以从  Subject subject = SecurityUtils.getSubject();  
        //return (String)subject.getPrincipals().asList().get(0); 中取得，因为已经整合后 cas 交给了 shiro-cas  
    /*  PermissionService service = (PermissionService)SpringContextUtil.getBean("PermissionService");  
        List<String> codes = service.findPermissionCodeByUsername(username); 
        if(codes != null && codes.size() > 0){ 
             SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo(); 
                 for (String str : codes) 
                    { 
                        authorizationInfo.addStringPermission(str); 
//                       info.addRole(role); 
                    } 
                return authorizationInfo; 
        }*/  
       //return  null;  
    }  
	
	   /**
     * Authenticates a user and retrieves its information.
     * 
     * @param token the authentication token
     * @throws AuthenticationException if there is an error during authentication.
     */
    @Override
    @SuppressWarnings("unchecked")
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
    	log.debug("====================:"+(token instanceof UsernamePasswordToken));
        CasToken casToken = (CasToken) token;
        if (token == null) {
            return null;
        }
        
        String ticket = (String)casToken.getCredentials();
        if (!StringUtils.hasText(ticket)) {
            return null;
        }
        Cas20ServiceTicketValidator cas20ServiceTicketValidator=new Cas20ServiceTicketValidator(getCasServerUrlPrefix());
        cas20ServiceTicketValidator.setEncoding("utf-8");
        TicketValidator ticketValidator = cas20ServiceTicketValidator;
        
        //TicketValidator ticketValidator = ensureTicketValidator();

        try {
            // contact CAS server to validate service ticket
            Assertion casAssertion = ticketValidator.validate(ticket, getCasService());
            // get principal, user id and attributes
            AttributePrincipal casPrincipal = casAssertion.getPrincipal();
            String userId = casPrincipal.getName();
            log.debug("Validate ticket : {} in CAS server : {} to retrieve user : {}", new Object[]{
                    ticket, getCasServerUrlPrefix(), userId
            });

            Map<String, Object> attributes = casPrincipal.getAttributes();
            // refresh authentication token (user id + remember me)
            casToken.setUserId(userId);
            String rememberMeAttributeName = getRememberMeAttributeName();
            String rememberMeStringValue = (String)attributes.get(rememberMeAttributeName);
            boolean isRemembered = rememberMeStringValue != null && Boolean.parseBoolean(rememberMeStringValue);
            if (isRemembered) {
                casToken.setRememberMe(true);
            }
            // create simple authentication info
//            List<Object> principals = CollectionUtils.asList(userId, attributes);
            log.debug("userId:==========="+userId);
            User user = getSystemService().getUserByLoginName(userId);
            if (user != null) {
            	
	            byte[] salt = Encodes.decodeHex("02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032".substring(0,16));
	            Principal p=new Principal(user, false);
	            List<Principal> principals=Lists.newArrayList();
	            principals.add(p);
//	            return new SimpleAuthenticationInfo(new Principal(user, false), 
//						"02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032".substring(16), ByteSource.Util.bytes(salt), getName());
	            PrincipalCollection principalCollection = new SimplePrincipalCollection(principals, getName());
	            return new SimpleAuthenticationInfo(principalCollection, ticket);
            }else{
            	return null;
            }
        } catch (TicketValidationException e) { 
            throw new CasAuthenticationException("Unable to validate ticket [" + ticket + "]", e);
        }
    }
}

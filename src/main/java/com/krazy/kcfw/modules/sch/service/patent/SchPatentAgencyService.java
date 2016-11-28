/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.patent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentAgency;
import com.krazy.kcfw.modules.sys.entity.Office;
import com.krazy.kcfw.modules.sys.entity.Role;
import com.krazy.kcfw.modules.sys.entity.User;
import com.krazy.kcfw.modules.sys.service.SystemService;
import com.krazy.kcfw.modules.sch.dao.patent.SchPatentAgencyDao;

/**
 * 专利机构信息Service
 * @author Krazy
 * @version 2016-11-21
 */
@Service
@Transactional(readOnly = true)
public class SchPatentAgencyService extends CrudService<SchPatentAgencyDao, SchPatentAgency> {

	@Autowired
	private SystemService systemService;
	
	public SchPatentAgency get(String id) {
		return super.get(id);
	}
	
	public List<SchPatentAgency> findList(SchPatentAgency schPatentAgency) {
		return super.findList(schPatentAgency);
	}
	
	public Page<SchPatentAgency> findPage(Page<SchPatentAgency> page, SchPatentAgency schPatentAgency) {
		schPatentAgency.getSqlMap().put("dsf", dataScopeFilter(schPatentAgency.getCurrentUser(), "o", "u"));
		return super.findPage(page, schPatentAgency);
	}
	
	@Transactional(readOnly = false)
	public void save(SchPatentAgency schPatentAgency) {
		super.save(schPatentAgency);
		
		//生成代理机构用户
		User user=new User();
		user.setCompany(new Office("99999"));
		user.setOffice(new Office("99999"));
		user.setNo(schPatentAgency.getSpaCode());
		user.setName(schPatentAgency.getSpaName());																																																																																																																																																																																										
		user.setLoginName(schPatentAgency.getSpaCode());
		user.setPhone(schPatentAgency.getSpaPhone());
		user.setPassword(SystemService.entryptPassword(schPatentAgency.getSpaPhone()));
		user.setLoginFlag("1");
		
		List<Role> roleList = Lists.newArrayList();
		roleList.add(new Role("99999"));
		user.setRoleList(roleList);
		
		// 保存用户信息
		systemService.saveUser(user);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchPatentAgency schPatentAgency) {
		
		//删除代理机构用户
		User user=systemService.getUserByLoginName(schPatentAgency.getSpaCode());
		systemService.deleteUser(user);
		super.delete(schPatentAgency);
	}

	@Transactional(readOnly = false)
	public void changePW(SchPatentAgency schPatentAgency) {
		// TODO Auto-generated method s
		User user=systemService.getUserByLoginName(schPatentAgency.getId());
		systemService.updatePasswordById(user.getId(), user.getLoginName(),schPatentAgency.getPassword());
	}
	
}
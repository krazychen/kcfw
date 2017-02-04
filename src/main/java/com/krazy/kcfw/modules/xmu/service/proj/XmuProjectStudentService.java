/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.proj;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectStudentDao;

/**
 * 项目人员Service
 * @author Krazy
 * @version 2017-02-03
 */
@Service
@Transactional(readOnly = true)
public class XmuProjectStudentService extends CrudService<XmuProjectStudentDao, XmuProjectStudent> {

	public XmuProjectStudent get(String id) {
		return super.get(id);
	}
	
	public List<XmuProjectStudent> findList(XmuProjectStudent xmuProjectStudent) {
		xmuProjectStudent.getSqlMap().put("dsf", dataScopeFilter(xmuProjectStudent.getCurrentUser(), "o", "u"));
		return super.findList(xmuProjectStudent);
	}
	
	public Page<XmuProjectStudent> findPage(Page<XmuProjectStudent> page, XmuProjectStudent xmuProjectStudent) {
		xmuProjectStudent.getSqlMap().put("dsf", dataScopeFilter(xmuProjectStudent.getCurrentUser(), "o", "u"));
		return super.findPage(page, xmuProjectStudent);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuProjectStudent xmuProjectStudent) {
		super.save(xmuProjectStudent);
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuProjectStudent xmuProjectStudent) {
		super.delete(xmuProjectStudent);
	}
	
	public Page<XmuProjectStudent> findUserList(Page<XmuProjectStudent> page, XmuProjectStudent xmuProjectStudent) {
		xmuProjectStudent.setPage(page);
		page.setList(dao.findUserList(xmuProjectStudent));
		return page;
	}
}
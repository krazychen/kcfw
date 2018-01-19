/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.res;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.xmu.entity.res.XmuExpertLecture;
import com.krazy.kcfw.modules.xmu.dao.res.XmuExpertLectureDao;

/**
 * 专家讲座Service
 * @author Krazy
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class XmuExpertLectureService extends CrudService<XmuExpertLectureDao, XmuExpertLecture> {

	public XmuExpertLecture get(String id) {
		return super.get(id);
	}
	
	public List<XmuExpertLecture> findList(XmuExpertLecture xmuExpertLecture) {
		xmuExpertLecture.getSqlMap().put("dsf", dataScopeFilter(xmuExpertLecture.getCurrentUser(), "o", "u"));
		return super.findList(xmuExpertLecture);
	}
	
	public Page<XmuExpertLecture> findPage(Page<XmuExpertLecture> page, XmuExpertLecture xmuExpertLecture) {
		xmuExpertLecture.getSqlMap().put("dsf", dataScopeFilter(xmuExpertLecture.getCurrentUser(), "o", "u"));
		return super.findPage(page, xmuExpertLecture);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuExpertLecture xmuExpertLecture) {
		super.save(xmuExpertLecture);
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuExpertLecture xmuExpertLecture) {
		super.delete(xmuExpertLecture);
	}
	
	
}
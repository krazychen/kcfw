/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.res;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.xmu.entity.res.XmuExpertTeaching;
import com.krazy.kcfw.modules.xmu.dao.res.XmuExpertTeachingDao;

/**
 * 专家授课Service
 * @author Krazy
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class XmuExpertTeachingService extends CrudService<XmuExpertTeachingDao, XmuExpertTeaching> {

	public XmuExpertTeaching get(String id) {
		return super.get(id);
	}
	
	public List<XmuExpertTeaching> findList(XmuExpertTeaching xmuExpertTeaching) {
		xmuExpertTeaching.getSqlMap().put("dsf", dataScopeFilter(xmuExpertTeaching.getCurrentUser(), "o", "u"));
		return super.findList(xmuExpertTeaching);
	}
	
	public Page<XmuExpertTeaching> findPage(Page<XmuExpertTeaching> page, XmuExpertTeaching xmuExpertTeaching) {
		xmuExpertTeaching.getSqlMap().put("dsf", dataScopeFilter(xmuExpertTeaching.getCurrentUser(), "o", "u"));
		return super.findPage(page, xmuExpertTeaching);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuExpertTeaching xmuExpertTeaching) {
		super.save(xmuExpertTeaching);
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuExpertTeaching xmuExpertTeaching) {
		super.delete(xmuExpertTeaching);
	}
	
	
}
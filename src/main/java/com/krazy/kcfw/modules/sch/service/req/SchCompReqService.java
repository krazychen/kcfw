/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.req;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;
import com.krazy.kcfw.modules.sch.dao.req.SchCompReqDao;

/**
 * 需求Service
 * @author Krazy
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class SchCompReqService extends CrudService<SchCompReqDao, SchCompReq> {

	public SchCompReq get(String id) {
		return super.get(id);
	}
	
	public List<SchCompReq> findList(SchCompReq schCompReq) {
		schCompReq.getSqlMap().put("dsf", dataScopeFilter(schCompReq.getCurrentUser(), "o", "u"));
		return super.findList(schCompReq);
	}
	
	public Page<SchCompReq> findPage(Page<SchCompReq> page, SchCompReq schCompReq) {
		schCompReq.getSqlMap().put("dsf", dataScopeFilter(schCompReq.getCurrentUser(), "o", "u"));
		return super.findPage(page, schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void save(SchCompReq schCompReq) {
		
		schCompReq.setScrStatus("1");
		super.save(schCompReq);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchCompReq schCompReq) {
		super.delete(schCompReq);
	}
	
}
/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.echarts.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.echarts.entity.PieClass;
import com.krazy.kcfw.modules.echarts.dao.PieClassDao;

/**
 * 班级Service
 * @author lgf
 * @version 2016-05-26
 */
@Service
@Transactional(readOnly = true)
public class PieClassService extends CrudService<PieClassDao, PieClass> {

	public PieClass get(String id) {
		return super.get(id);
	}
	
	public List<PieClass> findList(PieClass pieClass) {
		return super.findList(pieClass);
	}
	
	public Page<PieClass> findPage(Page<PieClass> page, PieClass pieClass) {
		return super.findPage(page, pieClass);
	}
	
	@Transactional(readOnly = false)
	public void save(PieClass pieClass) {
		super.save(pieClass);
	}
	
	@Transactional(readOnly = false)
	public void delete(PieClass pieClass) {
		super.delete(pieClass);
	}
	
	
	
	
}
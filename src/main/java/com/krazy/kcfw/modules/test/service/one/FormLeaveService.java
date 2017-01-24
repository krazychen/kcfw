/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.service.one;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.test.entity.one.FormLeave;
import com.krazy.kcfw.modules.test.dao.one.FormLeaveDao;

/**
 * 请假表单Service
 * @author lgf
 * @version 2016-10-06
 */
@Service
@Transactional(readOnly = true)
public class FormLeaveService extends CrudService<FormLeaveDao, FormLeave> {

	public FormLeave get(String id) {
		return super.get(id);
	}
	
	public List<FormLeave> findList(FormLeave formLeave) {
		return super.findList(formLeave);
	}
	
	public Page<FormLeave> findPage(Page<FormLeave> page, FormLeave formLeave) {
		return super.findPage(page, formLeave);
	}
	
	@Transactional(readOnly = false)
	public void save(FormLeave formLeave) {
		super.save(formLeave);
	}
	
	@Transactional(readOnly = false)
	public void delete(FormLeave formLeave) {
		super.delete(formLeave);
	}
	
	
	
	
}
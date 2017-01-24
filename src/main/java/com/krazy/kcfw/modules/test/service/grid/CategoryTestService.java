/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.service.grid;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.test.entity.grid.CategoryTest;
import com.krazy.kcfw.modules.test.dao.grid.CategoryTestDao;

/**
 * 商品分类Service
 * @author liugf
 * @version 2016-10-04
 */
@Service
@Transactional(readOnly = true)
public class CategoryTestService extends CrudService<CategoryTestDao, CategoryTest> {

	public CategoryTest get(String id) {
		return super.get(id);
	}
	
	public List<CategoryTest> findList(CategoryTest categoryTest) {
		return super.findList(categoryTest);
	}
	
	public Page<CategoryTest> findPage(Page<CategoryTest> page, CategoryTest categoryTest) {
		return super.findPage(page, categoryTest);
	}
	
	@Transactional(readOnly = false)
	public void save(CategoryTest categoryTest) {
		super.save(categoryTest);
	}
	
	@Transactional(readOnly = false)
	public void delete(CategoryTest categoryTest) {
		super.delete(categoryTest);
	}
	
	
	
	
}
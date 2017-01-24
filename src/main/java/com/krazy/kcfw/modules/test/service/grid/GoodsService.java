/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.service.grid;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.modules.test.entity.grid.CategoryTest;
import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.test.entity.grid.Goods;
import com.krazy.kcfw.modules.test.dao.grid.GoodsDao;

/**
 * 商品Service
 * @author liugf
 * @version 2016-10-04
 */
@Service
@Transactional(readOnly = true)
public class GoodsService extends CrudService<GoodsDao, Goods> {

	public Goods get(String id) {
		return super.get(id);
	}
	
	public List<Goods> findList(Goods goods) {
		return super.findList(goods);
	}
	
	public Page<Goods> findPage(Page<Goods> page, Goods goods) {
		return super.findPage(page, goods);
	}
	
	@Transactional(readOnly = false)
	public void save(Goods goods) {
		super.save(goods);
	}
	
	@Transactional(readOnly = false)
	public void delete(Goods goods) {
		super.delete(goods);
	}
	
	public Page<CategoryTest> findPageBycategory(Page<CategoryTest> page, CategoryTest categoryTest) {
		categoryTest.setPage(page);
		page.setList(dao.findListBycategory(categoryTest));
		return page;
	}
	
	
	
}
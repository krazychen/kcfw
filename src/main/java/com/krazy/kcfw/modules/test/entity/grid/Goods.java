/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.entity.grid;

import com.krazy.kcfw.modules.test.entity.grid.CategoryTest;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 商品Entity
 * @author liugf
 * @version 2016-10-04
 */
public class Goods extends DataEntity<Goods> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 商品名称
	private CategoryTest categoryTest;		// 所属类型
	private String price;		// 价格
	
	public Goods() {
		super();
	}

	public Goods(String id){
		super(id);
	}

	@ExcelField(title="商品名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@ExcelField(title="所属类型", align=2, sort=2)
	public CategoryTest getCategoryTest() {
		return categoryTest;
	}

	public void setCategory(CategoryTest categoryTest) {
		this.categoryTest = categoryTest;
	}
	
	@ExcelField(title="价格", align=2, sort=3)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
}
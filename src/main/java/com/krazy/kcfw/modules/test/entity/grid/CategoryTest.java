/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.entity.grid;


import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 商品分类Entity
 * @author liugf
 * @version 2016-10-04
 */
public class CategoryTest extends DataEntity<CategoryTest> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 类型名
	
	public CategoryTest() {
		super();
	}

	public CategoryTest(String id){
		super(id);
	}

	@ExcelField(title="类型名", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
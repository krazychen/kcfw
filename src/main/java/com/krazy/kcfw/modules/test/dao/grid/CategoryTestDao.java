/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.dao.grid;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.test.entity.grid.CategoryTest;

/**
 * 商品分类DAO接口
 * @author liugf
 * @version 2016-10-04
 */
@MyBatisDao
public interface CategoryTestDao extends CrudDao<CategoryTest> {

	
}
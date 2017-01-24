/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.iim.dao;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.iim.entity.LayGroup;

/**
 * 群组DAO接口
 * @author lgf
 * @version 2016-08-07
 */
@MyBatisDao
public interface LayGroupDao extends CrudDao<LayGroup> {

	
}
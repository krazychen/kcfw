/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.echarts.dao;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.echarts.entity.PieClass;

/**
 * 班级DAO接口
 * @author lgf
 * @version 2016-05-26
 */
@MyBatisDao
public interface PieClassDao extends CrudDao<PieClass> {

	
}
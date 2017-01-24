/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.iim.dao;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.iim.entity.MyCalendar;


/**
 * 日历DAO接口
 * @author liugf
 * @version 2016-04-19
 */
@MyBatisDao
public interface MyCalendarDao extends CrudDao<MyCalendar> {
	
}
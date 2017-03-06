/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sys.dao;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sys.entity.SystemConfig;

/**
 * 系统配置DAO接口
 * @author liugf
 * @version 2016-02-07
 */
@MyBatisDao
public interface SystemConfigDao extends CrudDao<SystemConfig> {
	
}
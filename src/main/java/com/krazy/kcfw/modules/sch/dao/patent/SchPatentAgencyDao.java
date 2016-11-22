/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.patent;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentAgency;

/**
 * 专利机构信息DAO接口
 * @author Krazy
 * @version 2016-11-21
 */
@MyBatisDao
public interface SchPatentAgencyDao extends CrudDao<SchPatentAgency> {
	
}
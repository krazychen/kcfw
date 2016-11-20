/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.patent;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnderInventor;

/**
 * 发明专利（本科）DAO接口
 * @author Krazy
 * @version 2016-11-20
 */
@MyBatisDao
public interface SchPatentUnderInventorDao extends CrudDao<SchPatentUnderInventor> {
	
}
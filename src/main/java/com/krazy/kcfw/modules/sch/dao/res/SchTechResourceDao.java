/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.res;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;

/**
 * 科研资源DAO接口
 * @author Krazy
 * @version 2016-12-06
 */
@MyBatisDao
public interface SchTechResourceDao extends CrudDao<SchTechResource> {
	
	public SchTechResource getByStrCode(SchTechResource schTechResource);
	
}
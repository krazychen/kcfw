/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.contract;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;

/**
 * 普通合同DAO接口
 * @author Krazy
 * @version 2016-11-27
 */
@MyBatisDao
public interface SchComConcractDao extends CrudDao<SchComConcract> {
	//获取SCC no
	public SchComConcract getSCCNO(SchComConcract schComConcract);
}
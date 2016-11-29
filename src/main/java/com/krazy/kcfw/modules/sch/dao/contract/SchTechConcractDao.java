/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.contract;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.entity.contract.SchTechConcract;

/**
 * 技贸合同DAO接口
 * @author Krazy
 * @version 2016-11-27
 */
@MyBatisDao
public interface SchTechConcractDao extends CrudDao<SchTechConcract> {
	//获取SCC no
	public SchTechConcract getStcNO(SchTechConcract schTechConcract);
	
	public int updateStatus(SchTechConcract schTechConcract);
	
	public int updateTeachComment(SchTechConcract schTechConcract);
	
	public int updateRespComment(SchTechConcract schTechConcract);
	
	public int updateManaComment(SchTechConcract schTechConcract);
	
	public int updateFinalComment(SchTechConcract schTechConcract);
}
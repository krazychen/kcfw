/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.req;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.req.SchCompReq;

/**
 * 需求DAO接口
 * @author Krazy
 * @version 2016-11-30
 */
@MyBatisDao
public interface SchCompReqDao extends CrudDao<SchCompReq> {
	
	public int updateStatus(SchCompReq schCompReq);
	
	public int updateManaComment(SchCompReq schCompReq);
	
	public int updateRecComment(SchCompReq schCompReq);
	
	public int updateFinalComment(SchCompReq schCompReq);
	
	public Integer getAcceptTimes(SchCompReq schCompReq);
	
	public int updateAll(SchCompReq schCompReq);
}
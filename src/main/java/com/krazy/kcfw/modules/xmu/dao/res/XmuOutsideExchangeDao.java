/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuOutsideExchange;

/**
 * 校外交流DAO接口
 * @author Krazy
 * @version 2017-03-07
 */
@MyBatisDao
public interface XmuOutsideExchangeDao extends CrudDao<XmuOutsideExchange> {

	public int updateStatus(XmuOutsideExchange xmuOutsideExchange);
	
	public int updateCollegeStandby(XmuOutsideExchange xmuOutsideExchange);
	
	public int updateManageStandby(XmuOutsideExchange xmuOutsideExchange);
	
	public int updateCollegeComment(XmuOutsideExchange xmuOutsideExchange);
	
	public int updateManageComment(XmuOutsideExchange xmuOutsideExchange);		
}
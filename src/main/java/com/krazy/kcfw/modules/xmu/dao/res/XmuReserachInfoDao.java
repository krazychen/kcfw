/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuReserachInfo;

/**
 * 科研信息DAO接口
 * @author Krazy
 * @version 2017-03-07
 */
@MyBatisDao
public interface XmuReserachInfoDao extends CrudDao<XmuReserachInfo> {

	public int updateStatus(XmuReserachInfo xmuReserachInfo);
	
	public int updateCollegeStandby(XmuReserachInfo xmuReserachInfo);
	
	public int updateManageStandby(XmuReserachInfo xmuReserachInfo);
	
	public int updateCollegeComment(XmuReserachInfo xmuReserachInfo);
	
	public int updateManageComment(XmuReserachInfo xmuReserachInfo);	
	
}
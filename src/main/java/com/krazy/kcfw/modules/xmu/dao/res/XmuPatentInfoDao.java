/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPatentInfo;

/**
 * 专利信息DAO接口
 * @author Krazy
 * @version 2017-03-06
 */
@MyBatisDao
public interface XmuPatentInfoDao extends CrudDao<XmuPatentInfo> {

	public int updateStatus(XmuPatentInfo xmuPatentInfo);
	
	public int updateCollegeStandby(XmuPatentInfo xmuPatentInfo);
	
	public int updateManageStandby(XmuPatentInfo xmuPatentInfo);
	
	public int updateCollegeComment(XmuPatentInfo xmuPatentInfo);
	
	public int updateManageComment(XmuPatentInfo xmuPatentInfo);	
}
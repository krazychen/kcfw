/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;
import com.krazy.kcfw.modules.xmu.entity.res.XmuPagePub;

/**
 * 论文发表DAO接口
 * @author Krazy
 * @version 2017-03-06
 */
@MyBatisDao
public interface XmuPagePubDao extends CrudDao<XmuPagePub> {

	public int updateStatus(XmuPagePub xmuPagePub);
	
	public int updateCollegeStandby(XmuPagePub xmuPagePub);
	
	public int updateManageStandby(XmuPagePub xmuPagePub);
	
	public int updateCollegeComment(XmuPagePub xmuPagePub);
	
	public int updateManageComment(XmuPagePub xmuPagePub);	
}
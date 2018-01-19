/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;

/**
 * 学术活动DAO接口
 * @author Krazy
 * @version 2017-02-18
 */
@MyBatisDao
public interface XmuAcademicEventDao extends CrudDao<XmuAcademicEvent> {

	public int updateStatus(XmuAcademicEvent xmuAcademicEvent);
	
	public int updateCollegeStandby(XmuAcademicEvent xmuAcademicEvent);
	
	public int updateManageStandby(XmuAcademicEvent xmuAcademicEvent);
	
	public int updateCollegeComment(XmuAcademicEvent xmuAcademicEvent);
	
	public int updateManageComment(XmuAcademicEvent xmuAcademicEvent);
}
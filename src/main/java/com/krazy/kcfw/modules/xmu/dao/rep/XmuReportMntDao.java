/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.rep;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.rep.XmuReportMnt;
import com.krazy.kcfw.modules.xmu.entity.res.XmuAcademicEvent;

/**
 * 项目汇报管理DAO接口
 * @author Krazy
 * @version 2017-06-03
 */
@MyBatisDao
public interface XmuReportMntDao extends CrudDao<XmuReportMnt> {

	public int updateStatus(XmuReportMnt xmuReportMnt);
	
	public int updateCollegeStandby(XmuReportMnt xmuReportMnt);
	
	public int updateManageStandby(XmuReportMnt xmuReportMnt);
	
	public int updateCollegeComment(XmuReportMnt xmuReportMnt);
	
	public int updateManageComment(XmuReportMnt xmuReportMnt);
}
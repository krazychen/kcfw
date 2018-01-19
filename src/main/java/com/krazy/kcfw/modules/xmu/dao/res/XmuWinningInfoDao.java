/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.res;


import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.res.XmuWinningInfo;

/**
 * 获奖信息DAO接口
 * @author Krazy
 * @version 2017-03-07
 */
@MyBatisDao
public interface XmuWinningInfoDao extends CrudDao<XmuWinningInfo> {

	public int updateStatus(XmuWinningInfo xmuWinningInfo);
	
	public int updateCollegeStandby(XmuWinningInfo xmuWinningInfo);
	
	public int updateManageStandby(XmuWinningInfo xmuWinningInfo);
	
	public int updateCollegeComment(XmuWinningInfo xmuWinningInfo);
	
	public int updateManageComment(XmuWinningInfo xmuWinningInfo);	
	
}
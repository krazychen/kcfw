/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.proj;


import java.util.List;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectTeaching;

/**
 * 项目开课DAO接口
 * @author Krazy
 * @version 2017-02-13
 */
@MyBatisDao
public interface XmuProjectTeachingDao extends CrudDao<XmuProjectTeaching> {

	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity
	 * @return
	 */
	public List<XmuProjectTeaching> findTeachingInfoList(XmuProjectTeaching xmuProjectTeaching);
	
	public XmuProjectTeaching getTeachingInfo(String id);
}
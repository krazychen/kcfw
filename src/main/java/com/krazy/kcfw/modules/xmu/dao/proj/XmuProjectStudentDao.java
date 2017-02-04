/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.proj;


import java.util.List;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;

/**
 * 项目人员DAO接口
 * @author Krazy
 * @version 2017-02-03
 */
@MyBatisDao
public interface XmuProjectStudentDao extends CrudDao<XmuProjectStudent> {

	public List<XmuProjectStudent> findUserList(XmuProjectStudent entity);
}
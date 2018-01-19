/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.dao.proj;


import java.util.List;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;

/**
 * 项目DAO接口
 * @author Krazy
 * @version 2017-01-29
 */
@MyBatisDao
public interface XmuProjectDao extends CrudDao<XmuProject> {

	public List<XmuProject> findListForMana(XmuProject entity);
}
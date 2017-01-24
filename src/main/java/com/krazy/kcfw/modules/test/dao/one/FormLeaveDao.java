/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.dao.one;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.test.entity.one.FormLeave;

/**
 * 请假表单DAO接口
 * @author lgf
 * @version 2016-10-06
 */
@MyBatisDao
public interface FormLeaveDao extends CrudDao<FormLeave> {

	
}
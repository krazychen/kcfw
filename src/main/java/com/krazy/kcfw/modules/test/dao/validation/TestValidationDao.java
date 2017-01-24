/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.dao.validation;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.test.entity.validation.TestValidation;

/**
 * 测试校验功能DAO接口
 * @author lgf
 * @version 2016-10-05
 */
@MyBatisDao
public interface TestValidationDao extends CrudDao<TestValidation> {

	
}
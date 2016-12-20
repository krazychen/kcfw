/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.res;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResourceApply;

/**
 * 科研资源申请DAO接口
 * @author Krazy
 * @version 2016-12-14
 */
@MyBatisDao
public interface SchTechResourceApplyDao extends CrudDao<SchTechResourceApply> {
	public int updateStatus(SchTechResourceApply schTechResourceApply);
	public int updateApplyComment(SchTechResourceApply schTechResourceApply);
}
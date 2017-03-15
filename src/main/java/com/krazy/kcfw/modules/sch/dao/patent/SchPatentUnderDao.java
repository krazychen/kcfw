/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.dao.patent;

import java.util.List;

import com.krazy.kcfw.common.persistence.CrudDao;
import com.krazy.kcfw.common.persistence.annotation.MyBatisDao;
import com.krazy.kcfw.modules.oa.entity.TestAudit;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;

/**
 * 发明专利（本科）DAO接口
 * @author Krazy
 * @version 2016-11-20
 */
@MyBatisDao
public interface SchPatentUnderDao extends CrudDao<SchPatentUnder> {
	
	public List<SchPatentUnder> findProxyList(SchPatentUnder schPatentUnder);
	
	public int updateStatus(SchPatentUnder schPatentUnder);
	
	public int updateFirstText(SchPatentUnder schPatentUnder);
	
	public int updateLeadText(SchPatentUnder schPatentUnder);
	
	public int updateAgencyText(SchPatentUnder schPatentUnder);

	public int updateAll(SchPatentUnder schPatentUnder);
}
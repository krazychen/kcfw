/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.patent;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnder;
import com.krazy.kcfw.modules.sch.dao.patent.SchPatentUnderDao;
import com.krazy.kcfw.modules.sch.entity.patent.SchPatentUnderInventor;
import com.krazy.kcfw.modules.sch.dao.patent.SchPatentUnderInventorDao;

/**
 * 发明专利（本科）Service
 * @author Krazy
 * @version 2016-11-20
 */
@Service
@Transactional(readOnly = true)
public class SchPatentUnderService extends CrudService<SchPatentUnderDao, SchPatentUnder> {

	@Autowired
	private SchPatentUnderInventorDao schPatentUnderInventorDao;
	
	public SchPatentUnder get(String id) {
		SchPatentUnder schPatentUnder = super.get(id);
		schPatentUnder.setSchPatentUnderInventorList(schPatentUnderInventorDao.findList(new SchPatentUnderInventor(schPatentUnder)));
		return schPatentUnder;
	}
	
	public List<SchPatentUnder> findList(SchPatentUnder schPatentUnder) {
		return super.findList(schPatentUnder);
	}
	
	public Page<SchPatentUnder> findPage(Page<SchPatentUnder> page, SchPatentUnder schPatentUnder) {
		schPatentUnder.getSqlMap().put("dsf", dataScopeFilter(schPatentUnder.getCurrentUser(), "o", "u"));
		return super.findPage(page, schPatentUnder);
	}
	
	@Transactional(readOnly = false)
	public void save(SchPatentUnder schPatentUnder) {
		super.save(schPatentUnder);
		for (SchPatentUnderInventor schPatentUnderInventor : schPatentUnder.getSchPatentUnderInventorList()){
			if (schPatentUnderInventor.getId() == null){
				continue;
			}
			if (SchPatentUnderInventor.DEL_FLAG_NORMAL.equals(schPatentUnderInventor.getDelFlag())){
				if (StringUtils.isBlank(schPatentUnderInventor.getId())){
					schPatentUnderInventor.setSpiPatent(schPatentUnder);
					schPatentUnderInventor.preInsert();
					schPatentUnderInventorDao.insert(schPatentUnderInventor);
				}else{
					schPatentUnderInventor.preUpdate();
					schPatentUnderInventorDao.update(schPatentUnderInventor);
				}
			}else{
				schPatentUnderInventorDao.delete(schPatentUnderInventor);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(SchPatentUnder schPatentUnder) {
		super.delete(schPatentUnder);
		schPatentUnderInventorDao.delete(new SchPatentUnderInventor(schPatentUnder));
	}
	
}
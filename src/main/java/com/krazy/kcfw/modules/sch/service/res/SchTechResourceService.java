/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.res;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.sch.entity.res.SchTechResource;
import com.krazy.kcfw.modules.sch.dao.res.SchTechResourceDao;

/**
 * 科研资源Service
 * @author Krazy
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class SchTechResourceService extends CrudService<SchTechResourceDao, SchTechResource> {

	public SchTechResource get(String id) {
		return super.get(id);
	}
	
	public List<SchTechResource> findList(SchTechResource schTechResource) {
		schTechResource.getSqlMap().put("dsf", dataScopeFilter(schTechResource.getCurrentUser(), "o", "u"));
		return super.findList(schTechResource);
	}
	
	public Page<SchTechResource> findPage(Page<SchTechResource> page, SchTechResource schTechResource) {
		schTechResource.getSqlMap().put("dsf", dataScopeFilter(schTechResource.getCurrentUser(), "o", "u"));
		return super.findPage(page, schTechResource);
	}
	
	public Page<SchTechResource> findPageWithoutPer(Page<SchTechResource> page, SchTechResource schTechResource) {
		schTechResource.getSqlMap().put("dsf", "");
		return super.findPage(page, schTechResource);
	}
	
	@Transactional(readOnly = false)
	public void save(SchTechResource schTechResource) {
		super.save(schTechResource);
	}
	
	@Transactional(readOnly = false)
	public void saveList(List<SchTechResource> lists) {
		for(int i=0;i<lists.size();i++){
			SchTechResource strl=lists.get(i);
			SchTechResource str=dao.getByStrCode(strl);
			if(str==null){
				strl.preInsert();
				dao.insert(strl);
			}else{
				str.setStrTypeCode(strl.getStrTypeCode());
				str.setStrName(strl.getStrName());
				str.setStrUnit(strl.getStrUnit());
				str.setStrPices(strl.getStrPices());
				str.setStrBrand(strl.getStrBrand());
				str.setStrPrice(strl.getStrPrice());
				str.setStrCreateDate(strl.getStrCreateDate());
				str.setStrOfficeId(strl.getStrOfficeId());
				str.setStrUserId(strl.getStrUserId());
				str.preUpdate();
				dao.update(str);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(SchTechResource schTechResource) {
		super.delete(schTechResource);
	}
	
}
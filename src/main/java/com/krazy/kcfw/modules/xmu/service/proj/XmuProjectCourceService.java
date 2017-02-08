/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.proj;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectCource;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectStudent;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectCourceDao;

/**
 * 项目课程Service
 * @author Krazy
 * @version 2017-02-06
 */
@Service
@Transactional(readOnly = true)
public class XmuProjectCourceService extends CrudService<XmuProjectCourceDao, XmuProjectCource> {

	public XmuProjectCource get(String id) {
		return super.get(id);
	}
	
	public List<XmuProjectCource> findList(XmuProjectCource xmuProjectCource) {
		xmuProjectCource.getSqlMap().put("dsf", dataScopeFilter(xmuProjectCource.getCurrentUser(), "o", "u"));
		return super.findList(xmuProjectCource);
	}
	
	public Page<XmuProjectCource> findPage(Page<XmuProjectCource> page, XmuProjectCource xmuProjectCource) {
		xmuProjectCource.getSqlMap().put("dsf", dataScopeFilter(xmuProjectCource.getCurrentUser(), "o", "u"));
		return super.findPage(page, xmuProjectCource);
	}
	
	public Page<XmuProjectCource> findCourceInfoPage(Page<XmuProjectCource> page, XmuProjectCource xmuProjectCource) {
		xmuProjectCource.setPage(page);
		page.setList(dao.findCourceInfoList(xmuProjectCource));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(XmuProjectCource xmuProjectCource) {
		super.save(xmuProjectCource);
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuProjectCource xmuProjectCource) {
		super.delete(xmuProjectCource);
	}
	
	/**
	 * @param id
	 * @return
	 */
	public XmuProjectCource getCourceInfo(String id){
		return this.dao.getCourceInfo(id);
	}
	
	public String saveCourse(XmuProjectCource xmuProjectCource,List courceIdList){
		StringBuffer sb=new StringBuffer();
		
		for(int i=0;i<courceIdList.size();i++){
			XmuProjectCource saveP=this.getCourceInfo(String.valueOf(courceIdList.get(i)));
			
			XmuProjectCource qup=new XmuProjectCource();
			qup.setXpcCourseInfoId(saveP.getId());
			qup.setXpcProjId(xmuProjectCource.getXpcProjId());
			List<XmuProjectCource> qups= this.findList(qup);
			if(qups.size()>0){
				XmuProjectCource updateP=qups.get(0);
				updateP.preUpdate();
				this.dao.update(updateP);
			}else{	
				saveP.setXpcCourseInfoId(saveP.getId());
				saveP.setXpcProjId(xmuProjectCource.getXpcProjId());
				saveP.setXpcProjName(xmuProjectCource.getXpcProjName());
				saveP.setXpcOfficeId(UserUtils.getUser().getOffice().getId());
				saveP.setXpcOfficeName(UserUtils.getUser().getOffice().getName());
				saveP.preInsert();
				this.dao.insert(saveP);
			}
			sb.append("课程<"+saveP.getXpcCourseName()+">保存到"+"项目<"+xmuProjectCource.getXpcProjName()+">成功\n\r");
		}
		return sb.toString();

	}
	
	public void saveCourseList(List<XmuProjectCource> xmuProjectCourceList){
		
		for(XmuProjectCource xmuProjectCource : xmuProjectCourceList){
			if (xmuProjectCource.getId() == null){
				continue;
			}
			if (XmuProjectStudent.DEL_FLAG_NORMAL.equals(xmuProjectCource.getDelFlag())){
				if (StringUtils.isBlank(xmuProjectCource.getId())){
					xmuProjectCource.preInsert();
					this.dao.insert(xmuProjectCource);
				}else{
					xmuProjectCource.preUpdate();
					this.dao.update(xmuProjectCource);
				}
			}else{
				this.dao.delete(xmuProjectCource);
			}
		}

	}
}
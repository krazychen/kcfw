/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.service.proj;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.common.utils.StringUtils;
import com.krazy.kcfw.modules.sys.utils.UserUtils;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectTeaching;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectDao;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectTeachingDao;

/**
 * 项目开课Service
 * @author Krazy
 * @version 2017-02-13
 */
@Service
@Transactional(readOnly = true)
public class XmuProjectTeachingService extends CrudService<XmuProjectTeachingDao, XmuProjectTeaching> {

	@Autowired
	private XmuProjectDao xmuProjectDao;
	
	public XmuProjectTeaching get(String id) {
		return super.get(id);
	}
	
	public List<XmuProjectTeaching> findList(XmuProjectTeaching xmuProjectTeaching) {
		xmuProjectTeaching.getSqlMap().put("dsf", dataScopeFilter(xmuProjectTeaching.getCurrentUser(), "o", "u"));
		return super.findList(xmuProjectTeaching);
	}
	
	public Page<XmuProjectTeaching> findPage(Page<XmuProjectTeaching> page, XmuProjectTeaching xmuProjectTeaching) {
		xmuProjectTeaching.getSqlMap().put("dsf", dataScopeFilter(xmuProjectTeaching.getCurrentUser(), "o", "u"));
		return super.findPage(page, xmuProjectTeaching);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuProjectTeaching xmuProjectTeaching) {
		super.save(xmuProjectTeaching);
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuProjectTeaching xmuProjectTeaching) {
		super.delete(xmuProjectTeaching);
	}
	
	public Page<XmuProjectTeaching> findCourceInfoPage(Page<XmuProjectTeaching> page, XmuProjectTeaching xmuProjectTeaching) {
		xmuProjectTeaching.setPage(page);
		page.setList(dao.findTeachingInfoList(xmuProjectTeaching));
		return page;
	}
	
	@Transactional(readOnly = false)
	public String saveTeaching(XmuProjectTeaching xmuProjectTeaching,List teachingIdList) {
		StringBuffer sb=new StringBuffer();
		
		for(int i=0;i<teachingIdList.size();i++){
			XmuProjectTeaching saveP=this.getTeachingInfo(String.valueOf(teachingIdList.get(i)));
			
			XmuProjectTeaching qup=new XmuProjectTeaching();
			qup.setXptProjId(xmuProjectTeaching.getXptProjId());
			qup.setXptTeachingInfoId(saveP.getId());
			List<XmuProjectTeaching> qups=this.findList(qup);
			if(qups.size()>0){
				XmuProjectTeaching updateP=qups.get(0);
				updateP.preUpdate();
				this.dao.update(updateP);
			}else{
				XmuProject xp=xmuProjectDao.get(xmuProjectTeaching.getXptProjId());
				saveP.setXptTeachingInfoId(saveP.getId());
				saveP.setXptProjLevel(xp.getXmpLevel());
				saveP.setXptProjId(xmuProjectTeaching.getXptProjId());
				saveP.setXptProjName(xmuProjectTeaching.getXptProjName());
				saveP.setXptOfficeId(UserUtils.getUser().getOffice().getId());
				saveP.setXptOfficeName(UserUtils.getUser().getOffice().getName());
				saveP.preInsert();
				this.dao.insert(saveP);
				
			}
			sb.append("教学课程<"+saveP.getXptTeachingName()+">保存到"+"项目<"+xmuProjectTeaching.getXptProjName()+">成功\n\r");
		}
		return sb.toString();
	}

	private XmuProjectTeaching getTeachingInfo(String id) {
		// TODO Auto-generated method stub
		return this.dao.getTeachingInfo(id);
	}
	
	@Transactional(readOnly = false)
	public void saveTeachingList(List<XmuProjectTeaching> xmuProjectTeachingList ){
		for(XmuProjectTeaching xmuProjectTeaching:xmuProjectTeachingList){
			if (xmuProjectTeaching.getId() == null){
				continue;
			}
			if (XmuProjectTeaching.DEL_FLAG_NORMAL.equals(xmuProjectTeaching.getDelFlag())){
				if (StringUtils.isBlank(xmuProjectTeaching.getId())){
					xmuProjectTeaching.preInsert();
					this.dao.insert(xmuProjectTeaching);
				}else{
					xmuProjectTeaching.preUpdate();
					this.dao.update(xmuProjectTeaching);
				}
			}else{
				this.dao.delete(xmuProjectTeaching);
			}
		}
	}
	
}
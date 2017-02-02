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
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProject;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectDao;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectMana;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectManaDao;
import com.krazy.kcfw.modules.xmu.entity.proj.XmuProjectResp;
import com.krazy.kcfw.modules.xmu.dao.proj.XmuProjectRespDao;

/**
 * 项目Service
 * @author Krazy
 * @version 2017-01-29
 */
@Service
@Transactional(readOnly = true)
public class XmuProjectService extends CrudService<XmuProjectDao, XmuProject> {

	@Autowired
	private XmuProjectManaDao xmuProjectManaDao;
	@Autowired
	private XmuProjectRespDao xmuProjectRespDao;
	
	public XmuProject get(String id) {
		XmuProject xmuProject = super.get(id);
		xmuProject.setXmuProjectManaList(xmuProjectManaDao.findList(new XmuProjectMana(xmuProject)));
		xmuProject.setXmuProjectRespList(xmuProjectRespDao.findList(new XmuProjectResp(xmuProject)));
		return xmuProject;
	}
	
	public List<XmuProject> findList(XmuProject xmuProject) {
		return super.findList(xmuProject);
	}
	
	public Page<XmuProject> findPage(Page<XmuProject> page, XmuProject xmuProject) {
		return super.findPage(page, xmuProject);
	}
	
	@Transactional(readOnly = false)
	public void save(XmuProject xmuProject) {
		super.save(xmuProject);
		XmuProjectMana delxmuProjectMana=new XmuProjectMana();
		delxmuProjectMana.setXpmProjId(xmuProject);
		xmuProjectManaDao.delete(delxmuProjectMana);
		for (XmuProjectMana xmuProjectMana : xmuProject.getXmuProjectManaList()){
//			if (xmuProjectMana.getId() == null){
//				continue;
//			}
//			if (XmuProjectMana.DEL_FLAG_NORMAL.equals(xmuProjectMana.getDelFlag())){
//				if (StringUtils.isBlank(xmuProjectMana.getId())){
			if (StringUtils.isNoneBlank(xmuProjectMana.getXpmUserId())){
					xmuProjectMana.setXpmProjId(xmuProject);
					xmuProjectMana.preInsert();
					xmuProjectManaDao.insert(xmuProjectMana);
			}
//				}else{
//					xmuProjectMana.preUpdate();
//					xmuProjectManaDao.update(xmuProjectMana);
//				}
//			}else{
//				xmuProjectManaDao.delete(xmuProjectMana);
//			}
		}
		XmuProjectResp delxmuXmuProjectResp=new XmuProjectResp();
		delxmuXmuProjectResp.setXprProjId(xmuProject);
		xmuProjectRespDao.delete(delxmuXmuProjectResp);
		for (XmuProjectResp xmuProjectResp : xmuProject.getXmuProjectRespList()){
//			if (xmuProjectResp.getId() == null){
//				continue;
//			}
//			if (XmuProjectResp.DEL_FLAG_NORMAL.equals(xmuProjectResp.getDelFlag())){
//				if (StringUtils.isBlank(xmuProjectResp.getId())){
			if (StringUtils.isNoneBlank(xmuProjectResp.getXprUserId())){
					xmuProjectResp.setXprProjId(xmuProject);
					xmuProjectResp.preInsert();
					xmuProjectRespDao.insert(xmuProjectResp);
			}
//				}else{
//					xmuProjectResp.preUpdate();
//					xmuProjectRespDao.update(xmuProjectResp);
//				}
//			}else{
//				xmuProjectRespDao.delete(xmuProjectResp);
//			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(XmuProject xmuProject) {
		super.delete(xmuProject);
		xmuProjectManaDao.delete(new XmuProjectMana(xmuProject));
		xmuProjectRespDao.delete(new XmuProjectResp(xmuProject));
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.proj;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目Entity
 * @author Krazy
 * @version 2017-01-29
 */
public class XmuProject extends DataEntity<XmuProject> {
	
	private static final long serialVersionUID = 1L;
	private String xmpName;		// 项目名称
	private String xmpLevel;		// 项目级别
	private Date xmpMaintDate;		// 项目维护开始时间
	private Date xmpEndDate;		// 项目维护结束时间
	private String xmpStatus;		// 项目状态
	private String xmpDescp;		// 项目简介
	private Date xmpStopDate;		// 项目停用时间
	private List<XmuProjectMana> xmuProjectManaList = Lists.newArrayList();		// 子表列表
	private List<XmuProjectResp> xmuProjectRespList = Lists.newArrayList();		// 子表列表
	private List<XmuProjectStudent> xmuProjectStudentList = Lists.newArrayList();		// 子表列表
	private List xpsUserIds;		// 学生IDs
	
	
	
	/**
	 * @return the xpsUserIds
	 */
	public List getXpsUserIds() {
		return xpsUserIds;
	}

	/**
	 * @param xpsUserIds the xpsUserIds to set
	 */
	public void setXpsUserIds(List xpsUserIds) {
		this.xpsUserIds = xpsUserIds;
	}

	public XmuProject() {
		super();
	}

	public XmuProject(String id){
		super(id);
	}

	@Length(min=1, max=200, message="项目名称长度必须介于 1 和 200 之间")
	@ExcelField(title="项目名称", align=2, sort=0)
	public String getXmpName() {
		return xmpName;
	}

	public void setXmpName(String xmpName) {
		this.xmpName = xmpName;
	}
	
	@Length(min=1, max=64, message="项目级别长度必须介于 1 和 64 之间")
	@ExcelField(title="项目级别", dictType="XMU_PROJECT_LEVEL", align=2, sort=1)
	public String getXmpLevel() {
		return xmpLevel;
	}

	public void setXmpLevel(String xmpLevel) {
		this.xmpLevel = xmpLevel;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="项目维护开始时间", align=2, sort=2)
	public Date getXmpMaintDate() {
		return xmpMaintDate;
	}

	public void setXmpMaintDate(Date xmpMaintDate) {
		this.xmpMaintDate = xmpMaintDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="项目维护结束时间", align=2, sort=3)
	public Date getXmpEndDate() {
		return xmpEndDate;
	}

	public void setXmpEndDate(Date xmpEndDate) {
		this.xmpEndDate = xmpEndDate;
	}
	
	@Length(min=1, max=64, message="项目状态长度必须介于 1 和 64 之间")
	@ExcelField(title="项目状态", dictType="XMU_PROJECT_STATUS", align=2, sort=4)
	public String getXmpStatus() {
		return xmpStatus;
	}

	public void setXmpStatus(String xmpStatus) {
		this.xmpStatus = xmpStatus;
	}
	
	@Length(min=0, max=2000, message="项目简介长度必须介于 0 和 2000 之间")
	@ExcelField(title="项目简介", align=2, sort=7)
	public String getXmpDescp() {
		return xmpDescp;
	}

	public void setXmpDescp(String xmpDescp) {
		this.xmpDescp = xmpDescp;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="项目停用时间", align=2, sort=9)
	public Date getXmpStopDate() {
		return xmpStopDate;
	}

	public void setXmpStopDate(Date xmpStopDate) {
		this.xmpStopDate = xmpStopDate;
	}
	
	public List<XmuProjectMana> getXmuProjectManaList() {
		return xmuProjectManaList;
	}

	public void setXmuProjectManaList(List<XmuProjectMana> xmuProjectManaList) {
		this.xmuProjectManaList = xmuProjectManaList;
	}
	public List<XmuProjectResp> getXmuProjectRespList() {
		return xmuProjectRespList;
	}

	public void setXmuProjectRespList(List<XmuProjectResp> xmuProjectRespList) {
		this.xmuProjectRespList = xmuProjectRespList;
	}
	
	public List<XmuProjectStudent> getXmuProjectStudentList() {
		return xmuProjectStudentList;
	}

	public void setXmuProjectStudentList(List<XmuProjectStudent> xmuProjectStudentList) {
		this.xmuProjectStudentList = xmuProjectStudentList;
	}
}
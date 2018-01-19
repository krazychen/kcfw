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
import com.krazy.kcfw.common.persistence.Page;
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
	private List<XmuProjectCource> xmuProjectCourceList = Lists.newArrayList();		// 子表列表
	private List<XmuProjectTeaching> xmuProjectTeachingList = Lists.newArrayList();		// 子表列表
	private List xpsUserIds;		// 学生IDs
	private List xciCourseIds;	//课程IDS
	private List xptTeachingIds;	//课程IDS
	private Date currentDate;
	private Page<XmuProjectStudent> xmuProjectStudentPage;
	private String xpsUserName;		// 姓名
	private String xpuUserGrade;		// 年级
	private String xpuUserProfession;		// 专业
	private String xpuUserStuno;		// 学号
	
	
	/**
	 * @return the xpsUserName
	 */
	public String getXpsUserName() {
		return xpsUserName;
	}

	/**
	 * @param xpsUserName the xpsUserName to set
	 */
	public void setXpsUserName(String xpsUserName) {
		this.xpsUserName = xpsUserName;
	}

	/**
	 * @return the xpuUserGrade
	 */
	public String getXpuUserGrade() {
		return xpuUserGrade;
	}

	/**
	 * @param xpuUserGrade the xpuUserGrade to set
	 */
	public void setXpuUserGrade(String xpuUserGrade) {
		this.xpuUserGrade = xpuUserGrade;
	}

	/**
	 * @return the xpuUserProfession
	 */
	public String getXpuUserProfession() {
		return xpuUserProfession;
	}

	/**
	 * @param xpuUserProfession the xpuUserProfession to set
	 */
	public void setXpuUserProfession(String xpuUserProfession) {
		this.xpuUserProfession = xpuUserProfession;
	}

	/**
	 * @return the xpuUserStuno
	 */
	public String getXpuUserStuno() {
		return xpuUserStuno;
	}

	/**
	 * @param xpuUserStuno the xpuUserStuno to set
	 */
	public void setXpuUserStuno(String xpuUserStuno) {
		this.xpuUserStuno = xpuUserStuno;
	}

	/**
	 * @return the page
	 */
	public Page<XmuProjectStudent> getXmuProjectStudentPage() {
		return xmuProjectStudentPage;
	}

	/**
	 * @param page the page to set
	 */
	public void setXmuProjectStudentPage(Page<XmuProjectStudent> xmuProjectStudentPage) {
		this.xmuProjectStudentPage = xmuProjectStudentPage;
	}

	/**
	 * @return the currentDate
	 */
	public Date getCurrentDate() {
		return currentDate;
	}

	/**
	 * @param currentDate the currentDate to set
	 */
	public void setCurrentDate(Date currentDate) {
		this.currentDate = currentDate;
	}

	/**
	 * @return the xptTeachingIds
	 */
	public List getXptTeachingIds() {
		return xptTeachingIds;
	}

	/**
	 * @param xptTeachingIds the xptTeachingIds to set
	 */
	public void setXptTeachingIds(List xptTeachingIds) {
		this.xptTeachingIds = xptTeachingIds;
	}

	/**
	 * @return the xmuProjectTeachingList
	 */
	public List<XmuProjectTeaching> getXmuProjectTeachingList() {
		return xmuProjectTeachingList;
	}

	/**
	 * @param xmuProjectTeachingList the xmuProjectTeachingList to set
	 */
	public void setXmuProjectTeachingList(
			List<XmuProjectTeaching> xmuProjectTeachingList) {
		this.xmuProjectTeachingList = xmuProjectTeachingList;
	}

	/**
	 * @return the xmuProjectCourceList
	 */
	public List<XmuProjectCource> getXmuProjectCourceList() {
		return xmuProjectCourceList;
	}

	/**
	 * @param xmuProjectCourceList the xmuProjectCourceList to set
	 */
	public void setXmuProjectCourceList(List<XmuProjectCource> xmuProjectCourceList) {
		this.xmuProjectCourceList = xmuProjectCourceList;
	}

	/**
	 * @return the xciCourseIds
	 */
	public List getXciCourseIds() {
		return xciCourseIds;
	}

	/**
	 * @param xciCourseIds the xciCourseIds to set
	 */
	public void setXciCourseIds(List xciCourseIds) {
		this.xciCourseIds = xciCourseIds;
	}

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
	@ExcelField(title="项目名称",type=0, align=2, sort=0)
	public String getXmpName() {
		return xmpName;
	}

	public void setXmpName(String xmpName) {
		this.xmpName = xmpName;
	}
	
	@Length(min=1, max=64, message="项目级别长度必须介于 1 和 64 之间")
	@ExcelField(title="项目级别", type=0, align=2, sort=1)
	public String getXmpLevel() {
		return xmpLevel;
	}

	public void setXmpLevel(String xmpLevel) {
		this.xmpLevel = xmpLevel;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@ExcelField(title="项目维护开始时间",type=0, align=2, sort=2)
	public Date getXmpMaintDate() {
		return xmpMaintDate;
	}

	public void setXmpMaintDate(Date xmpMaintDate) {
		this.xmpMaintDate = xmpMaintDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@ExcelField(title="项目维护结束时间", type=0,align=2, sort=3)
	public Date getXmpEndDate() {
		return xmpEndDate;
	}

	public void setXmpEndDate(Date xmpEndDate) {
		this.xmpEndDate = xmpEndDate;
	}
	
	@Length(min=1, max=64, message="项目状态长度必须介于 1 和 64 之间")
	@ExcelField(title="项目状态", type=0, align=2, sort=4)
	public String getXmpStatus() {
		return xmpStatus;
	}

	public void setXmpStatus(String xmpStatus) {
		this.xmpStatus = xmpStatus;
	}
	
	@Length(min=0, max=2000, message="项目简介长度必须介于 0 和 2000 之间")
	@ExcelField(title="项目简介",type=0, align=2, sort=7)
	public String getXmpDescp() {
		return xmpDescp;
	}

	public void setXmpDescp(String xmpDescp) {
		this.xmpDescp = xmpDescp;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@ExcelField(title="项目停用时间",type=0, align=2, sort=9)
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
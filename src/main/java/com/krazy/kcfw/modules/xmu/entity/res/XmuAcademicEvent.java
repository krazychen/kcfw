/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.res;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 学术活动Entity
 * @author Krazy
 * @version 2017-02-18
 */
public class XmuAcademicEvent extends ActEntity<XmuAcademicEvent> {
	
	private static final long serialVersionUID = 1L;
	private String xaeOfficeName;		// 学生学院名称
	private String xaeUserProfession;		// 专业
	private String xaeUserName;		// 姓名
	private String xaeEventName;		// 学术活动名称
	private String xaeProjId;		// 项目ID
	private String xaeProjName;		// 项目名称
	private String xaeOfficeId;		// 学生学院ID
	private String xaeUserId;		// 学生ID
	private String xaeUserGrade;		// 年级
	private String xaeUserStuno;		// 学号
	private String xaeEventYears;		// 参加年份
	private String xaeEventType;		// 活动类型
	private String xaeEventAreaId;		// 国家或地区ID
	private String xaeEventAreaName;		// 地区
	private String xaeEventWay;		// 交流渠道
	private String xaeEventSchool;		// 交流学校
	private String procInsId;		// 流程实例ID
	private String xaeStatus;		// 活动状态
	private String xaeCollegeComment;		// 院系管理员审核意见
	private String xaeManageComment;		// 系统管理员审核意见
	private String xaeCollegeStandby;
	private String xaeManageStandby;
	private String urlType;

	/**
	 * @return the urlType
	 */
	public String getUrlType() {
		return urlType;
	}

	/**
	 * @param urlType the urlType to set
	 */
	public void setUrlType(String urlType) {
		this.urlType = urlType;
	}

	public XmuAcademicEvent() {
		super();
	}

	public XmuAcademicEvent(String id){
		super(id);
	}
	
	/**
	 * @return the xaeCollegeStandby
	 */
	public String getXaeCollegeStandby() {
		return xaeCollegeStandby;
	}

	/**
	 * @param xaeCollegeStandby the xaeCollegeStandby to set
	 */
	public void setXaeCollegeStandby(String xaeCollegeStandby) {
		this.xaeCollegeStandby = xaeCollegeStandby;
	}

	/**
	 * @return the xaeManageStandby
	 */
	public String getXaeManageStandby() {
		return xaeManageStandby;
	}

	/**
	 * @param xaeManageStandby the xaeManageStandby to set
	 */
	public void setXaeManageStandby(String xaeManageStandby) {
		this.xaeManageStandby = xaeManageStandby;
	}

	@Length(min=1, max=200, message="学生学院名称长度必须介于 1 和 200 之间")
	@ExcelField(title="学生学院名称", fieldType=String.class, value="", align=2, sort=0)
	public String getXaeOfficeName() {
		return xaeOfficeName;
	}

	public void setXaeOfficeName(String xaeOfficeName) {
		this.xaeOfficeName = xaeOfficeName;
	}
	
	@Length(min=0, max=64, message="专业长度必须介于 0 和 64 之间")
	@ExcelField(title="专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=1)
	public String getXaeUserProfession() {
		return xaeUserProfession;
	}

	public void setXaeUserProfession(String xaeUserProfession) {
		this.xaeUserProfession = xaeUserProfession;
	}
	
	@Length(min=1, max=2000, message="姓名长度必须介于 1 和 2000 之间")
	@ExcelField(title="姓名", align=2, sort=2)
	public String getXaeUserName() {
		return xaeUserName;
	}

	public void setXaeUserName(String xaeUserName) {
		this.xaeUserName = xaeUserName;
	}
	
	@Length(min=0, max=64, message="学术活动名称长度必须介于 0 和 64 之间")
	@ExcelField(title="学术活动名称", align=2, sort=3)
	public String getXaeEventName() {
		return xaeEventName;
	}

	public void setXaeEventName(String xaeEventName) {
		this.xaeEventName = xaeEventName;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	@ExcelField(title="项目ID", align=2, sort=10)
	public String getXaeProjId() {
		return xaeProjId;
	}

	public void setXaeProjId(String xaeProjId) {
		this.xaeProjId = xaeProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=11)
	public String getXaeProjName() {
		return xaeProjName;
	}

	public void setXaeProjName(String xaeProjName) {
		this.xaeProjName = xaeProjName;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学生学院ID", align=2, sort=12)
	public String getXaeOfficeId() {
		return xaeOfficeId;
	}

	public void setXaeOfficeId(String xaeOfficeId) {
		this.xaeOfficeId = xaeOfficeId;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生ID", align=2, sort=13)
	public String getXaeUserId() {
		return xaeUserId;
	}

	public void setXaeUserId(String xaeUserId) {
		this.xaeUserId = xaeUserId;
	}
	
	@Length(min=0, max=64, message="年级长度必须介于 0 和 64 之间")
	@ExcelField(title="年级", dictType="XMU_PROJECT_COR_GRADE", align=2, sort=14)
	public String getXaeUserGrade() {
		return xaeUserGrade;
	}

	public void setXaeUserGrade(String xaeUserGrade) {
		this.xaeUserGrade = xaeUserGrade;
	}
	
	@Length(min=0, max=64, message="学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学号", align=2, sort=15)
	public String getXaeUserStuno() {
		return xaeUserStuno;
	}

	public void setXaeUserStuno(String xaeUserStuno) {
		this.xaeUserStuno = xaeUserStuno;
	}
	
	@Length(min=0, max=64, message="参加年份长度必须介于 0 和 64 之间")
	@ExcelField(title="参加年份", align=2, sort=16)
	public String getXaeEventYears() {
		return xaeEventYears;
	}

	public void setXaeEventYears(String xaeEventYears) {
		this.xaeEventYears = xaeEventYears;
	}
	
	@Length(min=0, max=64, message="活动类型长度必须介于 0 和 64 之间")
	@ExcelField(title="活动类型", dictType="XMU_EVENT_TYPE", align=2, sort=17)
	public String getXaeEventType() {
		return xaeEventType;
	}

	public void setXaeEventType(String xaeEventType) {
		this.xaeEventType = xaeEventType;
	}
	
	@Length(min=0, max=64, message="国家或地区ID长度必须介于 0 和 64 之间")
	@ExcelField(title="国家或地区ID", align=2, sort=18)
	public String getXaeEventAreaId() {
		return xaeEventAreaId;
	}

	public void setXaeEventAreaId(String xaeEventAreaId) {
		this.xaeEventAreaId = xaeEventAreaId;
	}
	
	@Length(min=0, max=64, message="地区长度必须介于 0 和 64 之间")
	@ExcelField(title="地区", align=2, sort=19)
	public String getXaeEventAreaName() {
		return xaeEventAreaName;
	}

	public void setXaeEventAreaName(String xaeEventAreaName) {
		this.xaeEventAreaName = xaeEventAreaName;
	}
	
	@Length(min=0, max=64, message="交流渠道长度必须介于 0 和 64 之间")
	@ExcelField(title="交流渠道", dictType="XMU_EVENT_WAY", align=2, sort=20)
	public String getXaeEventWay() {
		return xaeEventWay;
	}

	public void setXaeEventWay(String xaeEventWay) {
		this.xaeEventWay = xaeEventWay;
	}
	
	@Length(min=0, max=64, message="交流学校长度必须介于 0 和 64 之间")
	@ExcelField(title="交流学校", dictType="XMU_EVENT_SCHOOL", align=2, sort=21)
	public String getXaeEventSchool() {
		return xaeEventSchool;
	}

	public void setXaeEventSchool(String xaeEventSchool) {
		this.xaeEventSchool = xaeEventSchool;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	@ExcelField(title="流程实例ID", align=2, sort=22)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="活动状态长度必须介于 0 和 64 之间")
	@ExcelField(title="活动状态", align=2, sort=23)
	public String getXaeStatus() {
		return xaeStatus;
	}

	public void setXaeStatus(String xaeStatus) {
		this.xaeStatus = xaeStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="院系管理员审核意见", align=2, sort=24)
	public String getXaeCollegeComment() {
		return xaeCollegeComment;
	}

	public void setXaeCollegeComment(String xaeCollegeComment) {
		this.xaeCollegeComment = xaeCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="系统管理员审核意见", align=2, sort=25)
	public String getXaeManageComment() {
		return xaeManageComment;
	}

	public void setXaeManageComment(String xaeManageComment) {
		this.xaeManageComment = xaeManageComment;
	}
	
}
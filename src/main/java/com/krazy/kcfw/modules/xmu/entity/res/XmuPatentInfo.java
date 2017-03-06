/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.res;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 专利信息Entity
 * @author Krazy
 * @version 2017-03-06
 */
public class XmuPatentInfo extends ActEntity<XmuPatentInfo> {
	
	private static final long serialVersionUID = 1L;
	private String xpiOfficeName;		// 学生学院名称
	private String xpiUserProfession;		// 学生专业
	private String xpiUserName;		// 学生名称
	private String xpiPatentName;		// 专利名称
	private String xpiProjId;		// 项目ID
	private String xpiProjName;		// 项目名称
	private String xpiOfficeId;		// 学生学院ID
	private String xpiUserId;		// 学生ID
	private String xpiUserGrade;		// 学生年级
	private String xpiUserStuno;		// 学生学号
	private String procInsId;		// 流程实例ID
	private String xpiStatus;		// 活动状态
	private String xpiCollegeComment;		// 院系管理员审核意见
	private String xpiManageComment;		// 系统管理员审核意见
	private String xpiCollegeStandby;		// 待审院系管理员
	private String xpiManageStandby;		// 待审系统管理员
	private String xpiPatentYears;		// 年份
	private String xpiPatentPno;		// 申请公开号
	private Date xpiPatentPtime;		// 申请公开日
	private String xpiPatentRemark;		// 备注
	private String urlType;
	
	public XmuPatentInfo() {
		super();
	}

	public XmuPatentInfo(String id){
		super(id);
	}
	
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

	@Length(min=1, max=200, message="学生学院名称长度必须介于 1 和 200 之间")
	@ExcelField(title="学生学院名称", fieldType=String.class, value="", align=2, sort=0)
	public String getXpiOfficeName() {
		return xpiOfficeName;
	}

	public void setXpiOfficeName(String xpiOfficeName) {
		this.xpiOfficeName = xpiOfficeName;
	}
	
	@Length(min=0, max=64, message="学生专业长度必须介于 0 和 64 之间")
	@ExcelField(title="学生专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=1)
	public String getXpiUserProfession() {
		return xpiUserProfession;
	}

	public void setXpiUserProfession(String xpiUserProfession) {
		this.xpiUserProfession = xpiUserProfession;
	}
	
	@Length(min=1, max=2000, message="学生名称长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生名称", align=2, sort=2)
	public String getXpiUserName() {
		return xpiUserName;
	}

	public void setXpiUserName(String xpiUserName) {
		this.xpiUserName = xpiUserName;
	}
	
	@Length(min=0, max=200, message="专利名称长度必须介于 0 和 200 之间")
	@ExcelField(title="专利名称", align=2, sort=3)
	public String getXpiPatentName() {
		return xpiPatentName;
	}

	public void setXpiPatentName(String xpiPatentName) {
		this.xpiPatentName = xpiPatentName;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	@ExcelField(title="项目ID", align=2, sort=10)
	public String getXpiProjId() {
		return xpiProjId;
	}

	public void setXpiProjId(String xpiProjId) {
		this.xpiProjId = xpiProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=11)
	public String getXpiProjName() {
		return xpiProjName;
	}

	public void setXpiProjName(String xpiProjName) {
		this.xpiProjName = xpiProjName;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学生学院ID", align=2, sort=12)
	public String getXpiOfficeId() {
		return xpiOfficeId;
	}

	public void setXpiOfficeId(String xpiOfficeId) {
		this.xpiOfficeId = xpiOfficeId;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生ID", align=2, sort=13)
	public String getXpiUserId() {
		return xpiUserId;
	}

	public void setXpiUserId(String xpiUserId) {
		this.xpiUserId = xpiUserId;
	}
	
	@Length(min=0, max=64, message="学生年级长度必须介于 0 和 64 之间")
	@ExcelField(title="学生年级", dictType="XMU_PROJECT_COR_GRADE", align=2, sort=14)
	public String getXpiUserGrade() {
		return xpiUserGrade;
	}

	public void setXpiUserGrade(String xpiUserGrade) {
		this.xpiUserGrade = xpiUserGrade;
	}
	
	@Length(min=0, max=64, message="学生学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学生学号", align=2, sort=15)
	public String getXpiUserStuno() {
		return xpiUserStuno;
	}

	public void setXpiUserStuno(String xpiUserStuno) {
		this.xpiUserStuno = xpiUserStuno;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	@ExcelField(title="流程实例ID", align=2, sort=16)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="活动状态长度必须介于 0 和 64 之间")
	@ExcelField(title="活动状态", align=2, sort=17)
	public String getXpiStatus() {
		return xpiStatus;
	}

	public void setXpiStatus(String xpiStatus) {
		this.xpiStatus = xpiStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="院系管理员审核意见", align=2, sort=18)
	public String getXpiCollegeComment() {
		return xpiCollegeComment;
	}

	public void setXpiCollegeComment(String xpiCollegeComment) {
		this.xpiCollegeComment = xpiCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="系统管理员审核意见", align=2, sort=19)
	public String getXpiManageComment() {
		return xpiManageComment;
	}

	public void setXpiManageComment(String xpiManageComment) {
		this.xpiManageComment = xpiManageComment;
	}
	
	@Length(min=0, max=1000, message="待审院系管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审院系管理员", align=2, sort=20)
	public String getXpiCollegeStandby() {
		return xpiCollegeStandby;
	}

	public void setXpiCollegeStandby(String xpiCollegeStandby) {
		this.xpiCollegeStandby = xpiCollegeStandby;
	}
	
	@Length(min=0, max=1000, message="待审系统管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审系统管理员", align=2, sort=21)
	public String getXpiManageStandby() {
		return xpiManageStandby;
	}

	public void setXpiManageStandby(String xpiManageStandby) {
		this.xpiManageStandby = xpiManageStandby;
	}
	
	@Length(min=0, max=64, message="年份长度必须介于 0 和 64 之间")
	@ExcelField(title="年份", align=2, sort=22)
	public String getXpiPatentYears() {
		return xpiPatentYears;
	}

	public void setXpiPatentYears(String xpiPatentYears) {
		this.xpiPatentYears = xpiPatentYears;
	}
	
	@Length(min=0, max=64, message="申请公开号长度必须介于 0 和 64 之间")
	@ExcelField(title="申请公开号", align=2, sort=23)
	public String getXpiPatentPno() {
		return xpiPatentPno;
	}

	public void setXpiPatentPno(String xpiPatentPno) {
		this.xpiPatentPno = xpiPatentPno;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="申请公开日", align=2, sort=24)
	public Date getXpiPatentPtime() {
		return xpiPatentPtime;
	}

	public void setXpiPatentPtime(Date xpiPatentPtime) {
		this.xpiPatentPtime = xpiPatentPtime;
	}
	
	@Length(min=0, max=2000, message="备注长度必须介于 0 和 2000 之间")
	@ExcelField(title="备注", align=2, sort=25)
	public String getXpiPatentRemark() {
		return xpiPatentRemark;
	}

	public void setXpiPatentRemark(String xpiPatentRemark) {
		this.xpiPatentRemark = xpiPatentRemark;
	}
	
}
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
 * 获奖信息Entity
 * @author Krazy
 * @version 2017-03-07
 */
public class XmuWinningInfo extends ActEntity<XmuWinningInfo> {
	
	private static final long serialVersionUID = 1L;
	private String xwiOfficeName;		// 学生学院名称
	private String xwiUserProfession;		// 学生专业
	private String xwiUserName;		// 学生名称
	private String xwiWinningName;		// 竞赛名称
	private Date xwiWinningYears;		// 年份
	private String xwiProjId;		// 项目ID
	private String xwiProjName;		// 项目名称
	private String xwiOfficeId;		// 学生学院ID
	private String xwiUserId;		// 学生ID
	private String xwiUserGrade;		// 学生年级
	private String xwiUserStuno;		// 学生学号
	private String procInsId;		// 流程实例ID
	private String xwiStatus;		// 活动状态
	private String xwiCollegeComment;		// 院系管理员审核意见
	private String xwiManageComment;		// 系统管理员审核意见
	private String xwiCollegeStandby;		// 待审院系管理员
	private String xwiManageStandby;		// 待审系统管理员
	private String xwiWinningLevel;		// 竞赛级别
	private String xwiWinningContent;		// 收获奖项
	private String urlType;
	
	public XmuWinningInfo() {
		super();
	}

	public XmuWinningInfo(String id){
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
	public String getXwiOfficeName() {
		return xwiOfficeName;
	}

	public void setXwiOfficeName(String xwiOfficeName) {
		this.xwiOfficeName = xwiOfficeName;
	}
	
	@Length(min=0, max=64, message="学生专业长度必须介于 0 和 64 之间")
	@ExcelField(title="学生专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=1)
	public String getXwiUserProfession() {
		return xwiUserProfession;
	}

	public void setXwiUserProfession(String xwiUserProfession) {
		this.xwiUserProfession = xwiUserProfession;
	}
	
	@Length(min=1, max=2000, message="学生名称长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生名称", align=2, sort=2)
	public String getXwiUserName() {
		return xwiUserName;
	}

	public void setXwiUserName(String xwiUserName) {
		this.xwiUserName = xwiUserName;
	}
	
	@Length(min=0, max=200, message="竞赛名称长度必须介于 0 和 200 之间")
	@ExcelField(title="竞赛名称", align=2, sort=3)
	public String getXwiWinningName() {
		return xwiWinningName;
	}

	public void setXwiWinningName(String xwiWinningName) {
		this.xwiWinningName = xwiWinningName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="年份", align=2, sort=4)
	public Date getXwiWinningYears() {
		return xwiWinningYears;
	}

	public void setXwiWinningYears(Date xwiWinningYears) {
		this.xwiWinningYears = xwiWinningYears;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	@ExcelField(title="项目ID", align=2, sort=11)
	public String getXwiProjId() {
		return xwiProjId;
	}

	public void setXwiProjId(String xwiProjId) {
		this.xwiProjId = xwiProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=12)
	public String getXwiProjName() {
		return xwiProjName;
	}

	public void setXwiProjName(String xwiProjName) {
		this.xwiProjName = xwiProjName;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学生学院ID", align=2, sort=13)
	public String getXwiOfficeId() {
		return xwiOfficeId;
	}

	public void setXwiOfficeId(String xwiOfficeId) {
		this.xwiOfficeId = xwiOfficeId;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生ID", align=2, sort=14)
	public String getXwiUserId() {
		return xwiUserId;
	}

	public void setXwiUserId(String xwiUserId) {
		this.xwiUserId = xwiUserId;
	}
	
	@Length(min=0, max=64, message="学生年级长度必须介于 0 和 64 之间")
	@ExcelField(title="学生年级", dictType="XMU_PROJECT_COR_GRADE", align=2, sort=15)
	public String getXwiUserGrade() {
		return xwiUserGrade;
	}

	public void setXwiUserGrade(String xwiUserGrade) {
		this.xwiUserGrade = xwiUserGrade;
	}
	
	@Length(min=0, max=64, message="学生学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学生学号", align=2, sort=16)
	public String getXwiUserStuno() {
		return xwiUserStuno;
	}

	public void setXwiUserStuno(String xwiUserStuno) {
		this.xwiUserStuno = xwiUserStuno;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	@ExcelField(title="流程实例ID", align=2, sort=17)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="活动状态长度必须介于 0 和 64 之间")
	@ExcelField(title="活动状态", align=2, sort=18)
	public String getXwiStatus() {
		return xwiStatus;
	}

	public void setXwiStatus(String xwiStatus) {
		this.xwiStatus = xwiStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="院系管理员审核意见", align=2, sort=19)
	public String getXwiCollegeComment() {
		return xwiCollegeComment;
	}

	public void setXwiCollegeComment(String xwiCollegeComment) {
		this.xwiCollegeComment = xwiCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="系统管理员审核意见", align=2, sort=20)
	public String getXwiManageComment() {
		return xwiManageComment;
	}

	public void setXwiManageComment(String xwiManageComment) {
		this.xwiManageComment = xwiManageComment;
	}
	
	@Length(min=0, max=1000, message="待审院系管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审院系管理员", align=2, sort=21)
	public String getXwiCollegeStandby() {
		return xwiCollegeStandby;
	}

	public void setXwiCollegeStandby(String xwiCollegeStandby) {
		this.xwiCollegeStandby = xwiCollegeStandby;
	}
	
	@Length(min=0, max=1000, message="待审系统管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审系统管理员", align=2, sort=22)
	public String getXwiManageStandby() {
		return xwiManageStandby;
	}

	public void setXwiManageStandby(String xwiManageStandby) {
		this.xwiManageStandby = xwiManageStandby;
	}
	
	@Length(min=0, max=64, message="竞赛级别长度必须介于 0 和 64 之间")
	@ExcelField(title="竞赛级别", dictType="XMU_WINNING_LEVEL", align=2, sort=23)
	public String getXwiWinningLevel() {
		return xwiWinningLevel;
	}

	public void setXwiWinningLevel(String xwiWinningLevel) {
		this.xwiWinningLevel = xwiWinningLevel;
	}
	
	@Length(min=0, max=64, message="收获奖项长度必须介于 0 和 2000之间")
	@ExcelField(title="收获奖项", align=2, sort=24)
	public String getXwiWinningContent() {
		return xwiWinningContent;
	}

	public void setXwiWinningContent(String xwiWinningContent) {
		this.xwiWinningContent = xwiWinningContent;
	}
	
}
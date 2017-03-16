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
 * 校外交流Entity
 * @author Krazy
 * @version 2017-03-07
 */
public class XmuOutsideExchange extends ActEntity<XmuOutsideExchange> {
	
	private static final long serialVersionUID = 1L;
	private String xoeOfficeName;		// 学生学院名称
	private String xoeUserProfession;		// 学生专业
	private String xoeUserName;		// 学生名称
	private String xoeExchangeYears;		// 交流年份
	private String xoeExchangeSchool;		// 交流学校
	private String xoeProjId;		// 项目ID
	private String xoeProjName;		// 项目名称
	private String xoeOfficeId;		// 学生学院ID
	private String xoeUserId;		// 学生ID
	private String xoeUserGrade;		// 学生年级
	private String xoeUserStuno;		// 学生学号
	private String procInsId;		// 流程实例ID
	private String xoeStatus;		// 活动状态
	private String xoeCollegeComment;		// 院系管理员审核意见
	private String xoeManageComment;		// 系统管理员审核意见
	private String xoeCollegeStandby;		// 待审院系管理员
	private String xoeManageStandby;		// 待审系统管理员
	private String xoeExchangeArea;		// 派往国家或地区
	private Date xoeExchangeTime;		// 交流时间
	private String xoeExchangeType;		// 交流类型
	private String xoeExchangeWay;		// 交流渠道
	private String urlType;
	
	public XmuOutsideExchange() {
		super();
	}

	public XmuOutsideExchange(String id){
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
	public String getXoeOfficeName() {
		return xoeOfficeName;
	}

	public void setXoeOfficeName(String xoeOfficeName) {
		this.xoeOfficeName = xoeOfficeName;
	}
	
	@Length(min=0, max=64, message="学生专业长度必须介于 0 和 64 之间")
	@ExcelField(title="学生专业", align=2, sort=1)
	public String getXoeUserProfession() {
		return xoeUserProfession;
	}

	public void setXoeUserProfession(String xoeUserProfession) {
		this.xoeUserProfession = xoeUserProfession;
	}
	
	@Length(min=1, max=2000, message="学生名称长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生名称", align=2, sort=2)
	public String getXoeUserName() {
		return xoeUserName;
	}

	public void setXoeUserName(String xoeUserName) {
		this.xoeUserName = xoeUserName;
	}
	
	
	@ExcelField(title="交流年份", align=2, sort=3)
	public String getXoeExchangeYears() {
		return xoeExchangeYears;
	}

	public void setXoeExchangeYears(String xoeExchangeYears) {
		this.xoeExchangeYears = xoeExchangeYears;
	}
	
	@Length(min=0, max=64, message="交流学校长度必须介于 0 和 64 之间")
	@ExcelField(title="交流学校", align=2, sort=4)
	public String getXoeExchangeSchool() {
		return xoeExchangeSchool;
	}

	public void setXoeExchangeSchool(String xoeExchangeSchool) {
		this.xoeExchangeSchool = xoeExchangeSchool;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	//@ExcelField(title="项目ID", align=2, sort=11)
	public String getXoeProjId() {
		return xoeProjId;
	}

	public void setXoeProjId(String xoeProjId) {
		this.xoeProjId = xoeProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=12)
	public String getXoeProjName() {
		return xoeProjName;
	}

	public void setXoeProjName(String xoeProjName) {
		this.xoeProjName = xoeProjName;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	//@ExcelField(title="学生学院ID", align=2, sort=13)
	public String getXoeOfficeId() {
		return xoeOfficeId;
	}

	public void setXoeOfficeId(String xoeOfficeId) {
		this.xoeOfficeId = xoeOfficeId;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	//@ExcelField(title="学生ID", align=2, sort=14)
	public String getXoeUserId() {
		return xoeUserId;
	}

	public void setXoeUserId(String xoeUserId) {
		this.xoeUserId = xoeUserId;
	}
	
	@Length(min=0, max=64, message="学生年级长度必须介于 0 和 64 之间")
	@ExcelField(title="学生年级", align=2, sort=15)
	public String getXoeUserGrade() {
		return xoeUserGrade;
	}

	public void setXoeUserGrade(String xoeUserGrade) {
		this.xoeUserGrade = xoeUserGrade;
	}
	
	@Length(min=0, max=64, message="学生学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学生学号", align=2, sort=16)
	public String getXoeUserStuno() {
		return xoeUserStuno;
	}

	public void setXoeUserStuno(String xoeUserStuno) {
		this.xoeUserStuno = xoeUserStuno;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="流程实例ID", align=2, sort=17)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="活动状态长度必须介于 0 和 64 之间")
	//@ExcelField(title="活动状态", align=2, sort=18)
	public String getXoeStatus() {
		return xoeStatus;
	}

	public void setXoeStatus(String xoeStatus) {
		this.xoeStatus = xoeStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	//@ExcelField(title="院系管理员审核意见", align=2, sort=19)
	public String getXoeCollegeComment() {
		return xoeCollegeComment;
	}

	public void setXoeCollegeComment(String xoeCollegeComment) {
		this.xoeCollegeComment = xoeCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	//@ExcelField(title="系统管理员审核意见", align=2, sort=20)
	public String getXoeManageComment() {
		return xoeManageComment;
	}

	public void setXoeManageComment(String xoeManageComment) {
		this.xoeManageComment = xoeManageComment;
	}
	
	@Length(min=0, max=1000, message="待审院系管理员长度必须介于 0 和 1000 之间")
	//@ExcelField(title="待审院系管理员", align=2, sort=21)
	public String getXoeCollegeStandby() {
		return xoeCollegeStandby;
	}

	public void setXoeCollegeStandby(String xoeCollegeStandby) {
		this.xoeCollegeStandby = xoeCollegeStandby;
	}
	
	@Length(min=0, max=1000, message="待审系统管理员长度必须介于 0 和 1000 之间")
	//@ExcelField(title="待审系统管理员", align=2, sort=22)
	public String getXoeManageStandby() {
		return xoeManageStandby;
	}

	public void setXoeManageStandby(String xoeManageStandby) {
		this.xoeManageStandby = xoeManageStandby;
	}
	
	@Length(min=0, max=200, message="派往国家或地区长度必须介于 0 和 200 之间")
	@ExcelField(title="派往国家或地区", align=2, sort=23)
	public String getXoeExchangeArea() {
		return xoeExchangeArea;
	}

	public void setXoeExchangeArea(String xoeExchangeArea) {
		this.xoeExchangeArea = xoeExchangeArea;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@ExcelField(title="交流时间", align=2, sort=24)
	public Date getXoeExchangeTime() {
		return xoeExchangeTime;
	}

	public void setXoeExchangeTime(Date xoeExchangeTime) {
		this.xoeExchangeTime = xoeExchangeTime;
	}
	
	@Length(min=0, max=64, message="交流类型长度必须介于 0 和 64 之间")
	@ExcelField(title="交流类型", dictType="XMU_EXCHANGE_TYPE", align=2, sort=25)
	public String getXoeExchangeType() {
		return xoeExchangeType;
	}

	public void setXoeExchangeType(String xoeExchangeType) {
		this.xoeExchangeType = xoeExchangeType;
	}
	
	@Length(min=0, max=64, message="交流渠道长度必须介于 0 和 64 之间")
	@ExcelField(title="交流渠道", dictType="XMU_EXCHANGE_WAY", align=2, sort=26)
	public String getXoeExchangeWay() {
		return xoeExchangeWay;
	}

	public void setXoeExchangeWay(String xoeExchangeWay) {
		this.xoeExchangeWay = xoeExchangeWay;
	}
	
}
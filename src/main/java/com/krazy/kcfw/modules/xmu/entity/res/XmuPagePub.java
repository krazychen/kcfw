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
 * 论文发表Entity
 * @author Krazy
 * @version 2017-03-06
 */
public class XmuPagePub extends ActEntity<XmuPagePub> {
	
	private static final long serialVersionUID = 1L;
	private String xppOfficeName;		// 学生学院名称
	private String xppUserProfession;		// 学生专业
	private String xppUserName;		// 学生名称
	private String xppPageName;		// 论文题目
	private String xppPageTime;		// 发表时间
	private String xppProjId;		// 项目ID
	private String xppProjName;		// 项目名称
	private String xppOfficeId;		// 学生学院ID
	private String xppUserId;		// 学生ID
	private String xppUserGrade;		// 学生年级
	private String xppUserStuno;		// 学生学号
	private String procInsId;		// 流程实例ID
	private String xppStatus;		// 审核状态
	private String xppCollegeComment;		// 院系管理员审核意见
	private String xppManageComment;		// 系统管理员审核意见
	private String xppCollegeStandby;		// 待审院系管理员
	private String xppManageStandby;		// 待审系统管理员
	private String xppPagePublication;		// 发表刊物
	private String xppPageAuthorNo;		// 第几作者
	private String xppPageType;		// 刊物类别
	private String xppPageFactor;		// 发表文章影响因子
	private String xppPageAttachment;		// 附件
	private String xppPageRemark;		// 备注
	private String urlType;
	
	public XmuPagePub() {
		super();
	}

	public XmuPagePub(String id){
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
	public String getXppOfficeName() {
		return xppOfficeName;
	}

	public void setXppOfficeName(String xppOfficeName) {
		this.xppOfficeName = xppOfficeName;
	}
	
	@Length(min=0, max=64, message="学生专业长度必须介于 0 和 64 之间")
	@ExcelField(title="学生专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=1)
	public String getXppUserProfession() {
		return xppUserProfession;
	}

	public void setXppUserProfession(String xppUserProfession) {
		this.xppUserProfession = xppUserProfession;
	}
	
	@Length(min=1, max=2000, message="学生名称长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生名称", align=2, sort=2)
	public String getXppUserName() {
		return xppUserName;
	}

	public void setXppUserName(String xppUserName) {
		this.xppUserName = xppUserName;
	}
	
	@Length(min=0, max=200, message="论文题目长度必须介于 0 和 200 之间")
	@ExcelField(title="论文题目", align=2, sort=3)
	public String getXppPageName() {
		return xppPageName;
	}

	public void setXppPageName(String xppPageName) {
		this.xppPageName = xppPageName;
	}
	
	@ExcelField(title="发表时间", align=2, sort=4)
	public String getXppPageTime() {
		return xppPageTime;
	}

	public void setXppPageTime(String xppPageTime) {
		this.xppPageTime = xppPageTime;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	//@ExcelField(title="项目ID", align=2, sort=11)
	public String getXppProjId() {
		return xppProjId;
	}

	public void setXppProjId(String xppProjId) {
		this.xppProjId = xppProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=12)
	public String getXppProjName() {
		return xppProjName;
	}

	public void setXppProjName(String xppProjName) {
		this.xppProjName = xppProjName;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	//@ExcelField(title="学生学院ID", align=2, sort=13)
	public String getXppOfficeId() {
		return xppOfficeId;
	}

	public void setXppOfficeId(String xppOfficeId) {
		this.xppOfficeId = xppOfficeId;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	//@ExcelField(title="学生ID", align=2, sort=14)
	public String getXppUserId() {
		return xppUserId;
	}

	public void setXppUserId(String xppUserId) {
		this.xppUserId = xppUserId;
	}
	
	@Length(min=0, max=64, message="学生年级长度必须介于 0 和 64 之间")
	@ExcelField(title="学生年级", align=2, sort=15)
	public String getXppUserGrade() {
		return xppUserGrade;
	}

	public void setXppUserGrade(String xppUserGrade) {
		this.xppUserGrade = xppUserGrade;
	}
	
	@Length(min=0, max=64, message="学生学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学生学号", align=2, sort=16)
	public String getXppUserStuno() {
		return xppUserStuno;
	}

	public void setXppUserStuno(String xppUserStuno) {
		this.xppUserStuno = xppUserStuno;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="流程实例ID", align=2, sort=17)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="审核状态长度必须介于 0 和 64 之间")
	//@ExcelField(title="审核状态", dictType="XMU_EVENT_STATUS", align=2, sort=18)
	public String getXppStatus() {
		return xppStatus;
	}

	public void setXppStatus(String xppStatus) {
		this.xppStatus = xppStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	//@ExcelField(title="院系管理员审核意见", align=2, sort=19)
	public String getXppCollegeComment() {
		return xppCollegeComment;
	}

	public void setXppCollegeComment(String xppCollegeComment) {
		this.xppCollegeComment = xppCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	//@ExcelField(title="系统管理员审核意见", align=2, sort=20)
	public String getXppManageComment() {
		return xppManageComment;
	}

	public void setXppManageComment(String xppManageComment) {
		this.xppManageComment = xppManageComment;
	}
	
	@Length(min=0, max=1000, message="待审院系管理员长度必须介于 0 和 1000 之间")
	//@ExcelField(title="待审院系管理员", align=2, sort=21)
	public String getXppCollegeStandby() {
		return xppCollegeStandby;
	}

	public void setXppCollegeStandby(String xppCollegeStandby) {
		this.xppCollegeStandby = xppCollegeStandby;
	}
	
	@Length(min=0, max=1000, message="待审系统管理员长度必须介于 0 和 1000 之间")
	//@ExcelField(title="待审系统管理员", align=2, sort=22)
	public String getXppManageStandby() {
		return xppManageStandby;
	}

	public void setXppManageStandby(String xppManageStandby) {
		this.xppManageStandby = xppManageStandby;
	}
	
	@Length(min=0, max=200, message="发表刊物长度必须介于 0 和 200 之间")
	@ExcelField(title="发表刊物", align=2, sort=23)
	public String getXppPagePublication() {
		return xppPagePublication;
	}

	public void setXppPagePublication(String xppPagePublication) {
		this.xppPagePublication = xppPagePublication;
	}
	
	@Length(min=0, max=64, message="第几作者长度必须介于 0 和 64 之间")
	@ExcelField(title="第几作者", align=2, sort=24)
	public String getXppPageAuthorNo() {
		return xppPageAuthorNo;
	}

	public void setXppPageAuthorNo(String xppPageAuthorNo) {
		this.xppPageAuthorNo = xppPageAuthorNo;
	}
	
	@Length(min=0, max=64, message="刊物类别长度必须介于 0 和 64 之间")
	@ExcelField(title="刊物类别", align=2, sort=25)
	public String getXppPageType() {
		return xppPageType;
	}

	public void setXppPageType(String xppPageType) {
		this.xppPageType = xppPageType;
	}
	
	@Length(min=0, max=64, message="发表文章影响因子长度必须介于 0 和 64 之间")
	@ExcelField(title="发表文章影响因子", align=2, sort=26)
	public String getXppPageFactor() {
		return xppPageFactor;
	}

	public void setXppPageFactor(String xppPageFactor) {
		this.xppPageFactor = xppPageFactor;
	}
	
	@Length(min=0, max=1000, message="附件长度必须介于 0 和 1000 之间")
	//@ExcelField(title="附件", align=2, sort=27)
	public String getXppPageAttachment() {
		return xppPageAttachment;
	}

	public void setXppPageAttachment(String xppPageAttachment) {
		this.xppPageAttachment = xppPageAttachment;
	}
	
	@Length(min=0, max=2000, message="备注长度必须介于 0 和 2000 之间")
	@ExcelField(title="备注", align=2, sort=28)
	public String getXppPageRemark() {
		return xppPageRemark;
	}

	public void setXppPageRemark(String xppPageRemark) {
		this.xppPageRemark = xppPageRemark;
	}
	
}
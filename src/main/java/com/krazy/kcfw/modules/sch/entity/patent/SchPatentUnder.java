/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.patent;

import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

import com.google.common.collect.Lists;
import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 发明专利（本科）Entity
 * @author Krazy
 * @version 2016-11-20
 */
public class SchPatentUnder extends ActEntity<SchPatentUnder> {
	
	private static final long serialVersionUID = 1L;
	private String spuName;		// 专利名称
	private String spuTypeCode;		// 专利类型代码
	private String spuTypeName;		// 专利类型名称
	private String spuApplySchoolName;		// 专利申请人
	private String spuApplyUserId;		// 联络人Id
	private String spuApplyUserName;		// 联络人
	private String spuApplyUserOfficeId;		// 所属院系Id
	private String spuApplyUserOfficeName;		// 所属院系
	private String spuApplyPhone;		// 联系电话
	private String spuAdvisTeacherId;		// 指导老师Id
	private String spuAdvisTeacherName;		// 指导老师
	private String spuAdvisTeacherLoginName;		// 指导老师登录名
	private String spuAdvisTeacherOfficeId;		// 指导老师所属院系Id
	private String spuAdvisTeacherOfficeName;		// 指导老师所属院系
	private String spuProxyId;		// 专利代理机构ID
	private String spuProxyName;	// 专利代理机构
	private String spuRemark;		// 专利摘要
	private String spuStatus;		// 状态
	private List<SchPatentUnderInventor> schPatentUnderInventorList = Lists.newArrayList();		// 子表列表
	
	protected Date createDateFrom;	// 创建日期From
	protected Date createDateTo;	// 创建日期To
	private String firstText;       //初审评审意见
	private String leadText;		//审核评审意见
	private String agencyText;		//机构评审意见
	
	private String spuProxyContact;	//专利机构显示信息
	private String spuProxyPhone;	//专利机构显示信息
	
	private String isTeacher; //是否是老师
	
	public SchPatentUnder() {
		super();
	}

	public SchPatentUnder(String id){
		super(id);
	}
	
	public String getIsTeacher() {
		return isTeacher;
	}

	public void setIsTeacher(String isTeacher) {
		this.isTeacher = isTeacher;
	}

	public String getSpuProxyPhone() {
		return spuProxyPhone;
	}

	public void setSpuProxyPhone(String spuProxyPhone) {
		this.spuProxyPhone = spuProxyPhone;
	}

	public String getSpuProxyContact() {
		return spuProxyContact;
	}

	public void setSpuProxyContact(String spuProxyContact) {
		this.spuProxyContact = spuProxyContact;
	}

	public String getFirstText() {
		return firstText;
	}

	public void setFirstText(String firstText) {
		this.firstText = firstText;
	}

	public String getLeadText() {
		return leadText;
	}

	public void setLeadText(String leadText) {
		this.leadText = leadText;
	}

	public String getAgencyText() {
		return agencyText;
	}

	public void setAgencyText(String agencyText) {
		this.agencyText = agencyText;
	}

	public Date getCreateDateFrom() {
		return createDateFrom;
	}

	public void setCreateDateFrom(Date createDateFrom) {
		this.createDateFrom = createDateFrom;
	}

	public Date getCreateDateTo() {
		return createDateTo;
	}

	public void setCreateDateTo(Date createDateTo) {
		this.createDateTo = createDateTo;
	}
	
	@Length(min=1, max=200, message="专利名称长度必须介于 1 和 200 之间")
	public String getSpuName() {
		return spuName;
	}

	public void setSpuName(String spuName) {
		this.spuName = spuName;
	}
	
	@Length(min=1, max=45, message="专利类型代码长度必须介于 1 和 45 之间")
	public String getSpuTypeCode() {
		return spuTypeCode;
	}

	public void setSpuTypeCode(String spuTypeCode) {
		this.spuTypeCode = spuTypeCode;
	}
	
	@Length(min=1, max=45, message="专利类型名称长度必须介于 1 和 45 之间")
	public String getSpuTypeName() {
		return spuTypeName;
	}

	public void setSpuTypeName(String spuTypeName) {
		this.spuTypeName = spuTypeName;
	}
	
	@Length(min=1, max=100, message="专利申请人长度必须介于 1 和 100 之间")
	public String getSpuApplySchoolName() {
		return spuApplySchoolName;
	}

	public void setSpuApplySchoolName(String spuApplySchoolName) {
		this.spuApplySchoolName = spuApplySchoolName;
	}
	
	@Length(min=1, max=64, message="联络人ID长度必须介于 1 和 64 之间")
	public String getSpuApplyUserId() {
		return spuApplyUserId;
	}

	public void setSpuApplyUserId(String spuApplyUserId) {
		this.spuApplyUserId = spuApplyUserId;
	}
	
	@Length(min=1, max=64, message="联络人长度必须介于 1 和 100 之间")
	public String getSpuApplyUserName() {
		return spuApplyUserName;
	}

	public void setSpuApplyUserName(String spuApplyUserName) {
		this.spuApplyUserName = spuApplyUserName;
	}
	
	@Length(min=1, max=64, message="所属院系ID长度必须介于 1 和 64 之间")
	public String getSpuApplyUserOfficeId() {
		return spuApplyUserOfficeId;
	}

	public void setSpuApplyUserOfficeId(String spuApplyUserOfficeId) {
		this.spuApplyUserOfficeId = spuApplyUserOfficeId;
	}
	
	@Length(min=1, max=64, message="所属院系长度必须介于 1 和 64 之间")
	public String getSpuApplyUserOfficeName() {
		return spuApplyUserOfficeName;
	}

	public void setSpuApplyUserOfficeName(String spuApplyUserOfficeName) {
		this.spuApplyUserOfficeName = spuApplyUserOfficeName;
	}
	
	@Length(min=1, max=45, message="联系电话长度必须介于 1 和 45 之间")
	public String getSpuApplyPhone() {
		return spuApplyPhone;
	}

	public void setSpuApplyPhone(String spuApplyPhone) {
		this.spuApplyPhone = spuApplyPhone;
	}
	
	@Length(min=1, max=64, message="指导老师Id长度必须介于 1 和 64 之间")
	public String getSpuAdvisTeacherId() {
		return spuAdvisTeacherId;
	}

	public void setSpuAdvisTeacherId(String spuAdvisTeacherId) {
		this.spuAdvisTeacherId = spuAdvisTeacherId;
	}
	
	@Length(min=1, max=64, message="指导老师长度必须介于 1 和 64 之间")
	public String getSpuAdvisTeacherName() {
		return spuAdvisTeacherName;
	}

	public void setSpuAdvisTeacherName(String spuAdvisTeacherName) {
		this.spuAdvisTeacherName = spuAdvisTeacherName;
	}
	
	@Length(min=1, max=64, message="指导老师Id所属院系长度必须介于 1 和 64 之间")
	public String getSpuAdvisTeacherOfficeId() {
		return spuAdvisTeacherOfficeId;
	}

	public void setSpuAdvisTeacherOfficeId(String spuAdvisTeacherOfficeId) {
		this.spuAdvisTeacherOfficeId = spuAdvisTeacherOfficeId;
	}
	
	@Length(min=1, max=64, message="指导老师所属院系长度必须介于 1 和 64 之间")
	public String getSpuAdvisTeacherOfficeName() {
		return spuAdvisTeacherOfficeName;
	}

	public void setSpuAdvisTeacherOfficeName(String spuAdvisTeacherOfficeName) {
		this.spuAdvisTeacherOfficeName = spuAdvisTeacherOfficeName;
	}
	
	public String getSpuAdvisTeacherLoginName() {
		return spuAdvisTeacherLoginName;
	}

	public void setSpuAdvisTeacherLoginName(String spuAdvisTeacherLoginName) {
		this.spuAdvisTeacherLoginName = spuAdvisTeacherLoginName;
	}

	@Length(min=1, max=45, message="专利代理机构长度必须介于 1 和 45 之间")
	public String getSpuProxyId() {
		return spuProxyId;
	}

	public void setSpuProxyId(String spuProxyId) {
		this.spuProxyId = spuProxyId;
	}
	
	@Length(min=1, max=45, message="专利代理机构长度必须介于 1 和 100 之间")
	public String getSpuProxyName() {
		return spuProxyName;
	}

	public void setSpuProxyName(String spuProxyName) {
		this.spuProxyName = spuProxyName;
	}
	
	@Length(min=1, max=2000, message="专利摘要长度必须介于 1 和 2000 之间")
	public String getSpuRemark() {
		return spuRemark;
	}

	public void setSpuRemark(String spuRemark) {
		this.spuRemark = spuRemark;
	}
	
	@Length(min=1, max=1, message="状态长度必须介于 1 和 2000 之间")
	public String getSpuStatus() {
		return spuStatus;
	}

	public void setSpuStatus(String spuStatus) {
		this.spuStatus = spuStatus;
	}

	public List<SchPatentUnderInventor> getSchPatentUnderInventorList() {
		return schPatentUnderInventorList;
	}

	public void setSchPatentUnderInventorList(List<SchPatentUnderInventor> schPatentUnderInventorList) {
		this.schPatentUnderInventorList = schPatentUnderInventorList;
	}
}
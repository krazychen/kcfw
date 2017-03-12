/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.contract;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 普通合同Entity
 * @author Krazy
 * @version 2016-11-27
 */
public class SchComConcract extends ActEntity<SchComConcract> {
	
	private static final long serialVersionUID = 1L;
	private String sccName;		// 合同名称
	private String sccNo;		// 合同编号
	private String sccType;		// 合同类别
	private String sccResearchType;		// 研究方向
	private String sccResearchTypeSub;		// 研究方向子目
	private String sccIndustry;		// 所属行业
	private String sccResponseUserId;		// 负责人
	private String sccResponseUserName;		// 负责人
	private String sccResponseOfficeId;		// 负责人所属院系
	private String sccResponseOfficeName;		// 负责人所属院系
	private String sccCompanyName;		// 合作企业名称
	private String sccCompanyArea;		// 合作企业地区
	private String sccCompanyAreaName;		// 合作企业地区
	private String sccCompanyType;		// 合作企业类别
	private String sccStatus;		// 合同状态
	private String sccFiles;		// 合同附件
	private Date sccSubmitDate;		// 合同签订日期
	private String sccTeachComment; 	//院系秘书审批意见
	private String sccRespComment;		//科研负责人审批意见
	private String sccManaComment;		//合同管理员审批意见
	private String sccFinalComment;		//合同管理员审批意见
	private String procInsId;	//流程实例ID
	private double sccMoney;	//合同金额
	
	public SchComConcract() {
		super();
	}

	public SchComConcract(String id){
		super(id);
	}
	

	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	public double getSccMoney() {
		return sccMoney;
	}

	public void setSccMoney(double sccMoney) {
		this.sccMoney = sccMoney;
	}

	public String getSccTeachComment() {
		return sccTeachComment;
	}

	public void setSccTeachComment(String sccTeachComment) {
		this.sccTeachComment = sccTeachComment;
	}

	public String getSccRespComment() {
		return sccRespComment;
	}

	public void setSccRespComment(String sccRespComment) {
		this.sccRespComment = sccRespComment;
	}

	public String getSccManaComment() {
		return sccManaComment;
	}

	public void setSccManaComment(String sccManaComment) {
		this.sccManaComment = sccManaComment;
	}

	public String getSccFinalComment() {
		return sccFinalComment;
	}

	public void setSccFinalComment(String sccFinalComment) {
		this.sccFinalComment = sccFinalComment;
	}

	@Length(min=1, max=200, message="合同名称长度必须介于 1 和 200 之间")
	public String getSccName() {
		return sccName;
	}

	public void setSccName(String sccName) {
		this.sccName = sccName;
	}
	
	public String getSccNo() {
		return sccNo;
	}

	public void setSccNo(String sccNo) {
		this.sccNo = sccNo;
	}
	
	@Length(min=1, max=64, message="合同类别长度必须介于 1 和 64之间")
	public String getSccType() {
		return sccType;
	}

	public void setSccType(String sccType) {
		this.sccType = sccType;
	}
	
	@Length(min=1, max=64, message="研究方向长度必须介于 1 和 64 之间")
	public String getSccResearchType() {
		return sccResearchType;
	}

	public void setSccResearchType(String sccResearchType) {
		this.sccResearchType = sccResearchType;
	}
	
	@Length(min=1, max=64, message="研究方向子目长度必须介于 1 和 64 之间")
	public String getSccResearchTypeSub() {
		return sccResearchTypeSub;
	}

	public void setSccResearchTypeSub(String sccResearchTypeSub) {
		this.sccResearchTypeSub = sccResearchTypeSub;
	}
	
	@Length(min=1, max=64, message="所属行业长度必须介于 1 和 64之间")
	public String getSccIndustry() {
		return sccIndustry;
	}

	public void setSccIndustry(String sccIndustry) {
		this.sccIndustry = sccIndustry;
	}
	
	@Length(min=1, max=64, message="负责人长度必须介于 1 和 64 之间")
	public String getSccResponseUserId() {
		return sccResponseUserId;
	}

	public void setSccResponseUserId(String sccResponseUserId) {
		this.sccResponseUserId = sccResponseUserId;
	}
	
	public String getSccResponseUserName() {
		return sccResponseUserName;
	}

	public void setSccResponseUserName(String sccResponseUserName) {
		this.sccResponseUserName = sccResponseUserName;
	}

	public String getSccResponseOfficeName() {
		return sccResponseOfficeName;
	}

	public void setSccResponseOfficeName(String sccResponseOfficeName) {
		this.sccResponseOfficeName = sccResponseOfficeName;
	}

	@Length(min=1, max=64, message="负责人所属院系长度必须介于 1 和 64 之间")
	public String getSccResponseOfficeId() {
		return sccResponseOfficeId;
	}

	public void setSccResponseOfficeId(String sccResponseOfficeId) {
		this.sccResponseOfficeId = sccResponseOfficeId;
	}
	
	@Length(min=1, max=200, message="合作企业名称长度必须介于 1 和 200 之间")
	public String getSccCompanyName() {
		return sccCompanyName;
	}

	public void setSccCompanyName(String sccCompanyName) {
		this.sccCompanyName = sccCompanyName;
	}
	
	@Length(min=1, max=64, message="合作企业地区长度必须介于 1 和 64 之间")
	public String getSccCompanyArea() {
		return sccCompanyArea;
	}

	public void setSccCompanyArea(String sccCompanyArea) {
		this.sccCompanyArea = sccCompanyArea;
	}
	
	
	public String getSccCompanyAreaName() {
		return sccCompanyAreaName;
	}

	public void setSccCompanyAreaName(String sccCompanyAreaName) {
		this.sccCompanyAreaName = sccCompanyAreaName;
	}

	@Length(min=1, max=64, message="合作企业类别长度必须介于 1 和 64 之间")
	public String getSccCompanyType() {
		return sccCompanyType;
	}

	public void setSccCompanyType(String sccCompanyType) {
		this.sccCompanyType = sccCompanyType;
	}
	
	@Length(min=1, max=64, message="合同状态长度必须介于 1 和 64之间")
	public String getSccStatus() {
		return sccStatus;
	}

	public void setSccStatus(String sccStatus) {
		this.sccStatus = sccStatus;
	}
	
	@Length(min=0, max=1000, message="合同附件长度必须介于 0 和 1000 之间")
	public String getSccFiles() {
		return sccFiles;
	}

	public void setSccFiles(String sccFiles) {
		this.sccFiles = sccFiles;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="合同签订日期不能为空")
	public Date getSccSubmitDate() {
		return sccSubmitDate;
	}

	public void setSccSubmitDate(Date sccSubmitDate) {
		this.sccSubmitDate = sccSubmitDate;
	}
	
}
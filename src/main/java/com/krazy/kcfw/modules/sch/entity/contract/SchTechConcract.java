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
 * 技贸合同Entity
 * @author Krazy
 * @version 2016-11-27
 */
public class SchTechConcract extends ActEntity<SchTechConcract> {
	
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
	
	public SchTechConcract() {
		super();
	}

	public SchTechConcract(String id){
		super(id);
	}
	

	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	public double getStcMoney() {
		return sccMoney;
	}

	public void setStcMoney(double sccMoney) {
		this.sccMoney = sccMoney;
	}

	public String getStcTeachComment() {
		return sccTeachComment;
	}

	public void setStcTeachComment(String sccTeachComment) {
		this.sccTeachComment = sccTeachComment;
	}

	public String getStcRespComment() {
		return sccRespComment;
	}

	public void setStcRespComment(String sccRespComment) {
		this.sccRespComment = sccRespComment;
	}

	public String getStcManaComment() {
		return sccManaComment;
	}

	public void setStcManaComment(String sccManaComment) {
		this.sccManaComment = sccManaComment;
	}

	public String getStcFinalComment() {
		return sccFinalComment;
	}

	public void setStcFinalComment(String sccFinalComment) {
		this.sccFinalComment = sccFinalComment;
	}

	@Length(min=1, max=64, message="合同名称长度必须介于 1 和 64 之间")
	public String getStcName() {
		return sccName;
	}

	public void setStcName(String sccName) {
		this.sccName = sccName;
	}
	
	public String getStcNo() {
		return sccNo;
	}

	public void setStcNo(String sccNo) {
		this.sccNo = sccNo;
	}
	
	@Length(min=1, max=1, message="合同类别长度必须介于 1 和 1 之间")
	public String getStcType() {
		return sccType;
	}

	public void setStcType(String sccType) {
		this.sccType = sccType;
	}
	
	@Length(min=1, max=1, message="研究方向长度必须介于 1 和 1 之间")
	public String getStcResearchType() {
		return sccResearchType;
	}

	public void setStcResearchType(String sccResearchType) {
		this.sccResearchType = sccResearchType;
	}
	
	@Length(min=1, max=1, message="研究方向子目长度必须介于 1 和 1 之间")
	public String getStcResearchTypeSub() {
		return sccResearchTypeSub;
	}

	public void setStcResearchTypeSub(String sccResearchTypeSub) {
		this.sccResearchTypeSub = sccResearchTypeSub;
	}
	
	@Length(min=1, max=1, message="所属行业长度必须介于 1 和 1 之间")
	public String getStcIndustry() {
		return sccIndustry;
	}

	public void setStcIndustry(String sccIndustry) {
		this.sccIndustry = sccIndustry;
	}
	
	@Length(min=1, max=64, message="负责人长度必须介于 1 和 64 之间")
	public String getStcResponseUserId() {
		return sccResponseUserId;
	}

	public void setStcResponseUserId(String sccResponseUserId) {
		this.sccResponseUserId = sccResponseUserId;
	}
	
	public String getStcResponseUserName() {
		return sccResponseUserName;
	}

	public void setStcResponseUserName(String sccResponseUserName) {
		this.sccResponseUserName = sccResponseUserName;
	}

	public String getStcResponseOfficeName() {
		return sccResponseOfficeName;
	}

	public void setStcResponseOfficeName(String sccResponseOfficeName) {
		this.sccResponseOfficeName = sccResponseOfficeName;
	}

	@Length(min=1, max=64, message="负责人所属院系长度必须介于 1 和 64 之间")
	public String getStcResponseOfficeId() {
		return sccResponseOfficeId;
	}

	public void setStcResponseOfficeId(String sccResponseOfficeId) {
		this.sccResponseOfficeId = sccResponseOfficeId;
	}
	
	@Length(min=1, max=64, message="合作企业名称长度必须介于 1 和 64 之间")
	public String getStcCompanyName() {
		return sccCompanyName;
	}

	public void setStcCompanyName(String sccCompanyName) {
		this.sccCompanyName = sccCompanyName;
	}
	
	@Length(min=1, max=64, message="合作企业地区长度必须介于 1 和 64 之间")
	public String getStcCompanyArea() {
		return sccCompanyArea;
	}

	public void setStcCompanyArea(String sccCompanyArea) {
		this.sccCompanyArea = sccCompanyArea;
	}
	
	
	public String getStcCompanyAreaName() {
		return sccCompanyAreaName;
	}

	public void setStcCompanyAreaName(String sccCompanyAreaName) {
		this.sccCompanyAreaName = sccCompanyAreaName;
	}

	@Length(min=1, max=64, message="合作企业类别长度必须介于 1 和 64 之间")
	public String getStcCompanyType() {
		return sccCompanyType;
	}

	public void setStcCompanyType(String sccCompanyType) {
		this.sccCompanyType = sccCompanyType;
	}
	
	@Length(min=1, max=1, message="合同状态长度必须介于 1 和 1 之间")
	public String getStcStatus() {
		return sccStatus;
	}

	public void setStcStatus(String sccStatus) {
		this.sccStatus = sccStatus;
	}
	
	@Length(min=0, max=1000, message="合同附件长度必须介于 0 和 1000 之间")
	public String getStcFiles() {
		return sccFiles;
	}

	public void setStcFiles(String sccFiles) {
		this.sccFiles = sccFiles;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="合同签订日期不能为空")
	public Date getStcSubmitDate() {
		return sccSubmitDate;
	}

	public void setStcSubmitDate(Date sccSubmitDate) {
		this.sccSubmitDate = sccSubmitDate;
	}
	
}
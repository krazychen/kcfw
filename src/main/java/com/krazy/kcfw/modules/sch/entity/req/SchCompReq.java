/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.req;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

import javax.validation.constraints.DecimalMin;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 需求Entity
 * @author Krazy
 * @version 2016-11-30
 */
public class SchCompReq extends DataEntity<SchCompReq> {
	
	private static final long serialVersionUID = 1L;
	private String scrName;		// 难题名称
	private String scrStatus;		// 需求状态
	private String scrIndustry;		// 所属行业
	private String scrContent;		// 内容与说明
	private String scrMarket;		// 市场前景(方向)
	private String scrCoopMethod;		// 合作方式
	private Date scrExpiryDate;		// 失效日期
	private String scrCompanyName;		// 企业名称
	private String scrCompanyContact;		// 联系人
	private String scrCompanyPhone;		// 联系电话
	private String scrCompanyEmail;		// 电子邮箱
	private String scrFiles;		// 文件
	private String procInsId;		// 流程实例ID
	private String scrRecTeachId;		// 接受老师
	private String scrRecComment;		// 接受意见
	private String scrFinalComment;		// 完成意见
	
	public SchCompReq() {
		super();
	}

	public SchCompReq(String id){
		super(id);
	}

	@Length(min=1, max=100, message="难题名称长度必须介于 1 和 100 之间")
	public String getScrName() {
		return scrName;
	}

	public void setScrName(String scrName) {
		this.scrName = scrName;
	}
	
	@Length(min=1, max=64, message="需求状态长度必须介于 1 和 64 之间")
	public String getScrStatus() {
		return scrStatus;
	}

	public void setScrStatus(String scrStatus) {
		this.scrStatus = scrStatus;
	}
	
	@Length(min=1, max=64, message="所属行业长度必须介于 1 和 64 之间")
	public String getScrIndustry() {
		return scrIndustry;
	}

	public void setScrIndustry(String scrIndustry) {
		this.scrIndustry = scrIndustry;
	}
	
	@Length(min=1, max=2000, message="内容与说明长度必须介于 1 和 2000 之间")
	public String getScrContent() {
		return scrContent;
	}

	public void setScrContent(String scrContent) {
		this.scrContent = scrContent;
	}
	
	@Length(min=0, max=2000, message="市场前景(方向)长度必须介于 0 和 2000 之间")
	public String getScrMarket() {
		return scrMarket;
	}

	public void setScrMarket(String scrMarket) {
		this.scrMarket = scrMarket;
	}
	
	@Length(min=1, max=64, message="合作方式长度必须介于 1 和 64 之间")
	public String getScrCoopMethod() {
		return scrCoopMethod;
	}

	public void setScrCoopMethod(String scrCoopMethod) {
		this.scrCoopMethod = scrCoopMethod;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getScrExpiryDate() {
		return scrExpiryDate;
	}

	public void setScrExpiryDate(Date scrExpiryDate) {
		this.scrExpiryDate = scrExpiryDate;
	}
	
	@Length(min=1, max=64, message="企业名称长度必须介于 1 和 64 之间")
	public String getScrCompanyName() {
		return scrCompanyName;
	}

	public void setScrCompanyName(String scrCompanyName) {
		this.scrCompanyName = scrCompanyName;
	}
	
	@Length(min=1, max=64, message="联系人长度必须介于 1 和 64 之间")
	public String getScrCompanyContact() {
		return scrCompanyContact;
	}

	public void setScrCompanyContact(String scrCompanyContact) {
		this.scrCompanyContact = scrCompanyContact;
	}
	
	@Length(min=1, max=64, message="联系电话长度必须介于 1 和 64 之间")
	public String getScrCompanyPhone() {
		return scrCompanyPhone;
	}

	public void setScrCompanyPhone(String scrCompanyPhone) {
		this.scrCompanyPhone = scrCompanyPhone;
	}
	
	@Email(message="请输入正确的电子邮箱")
	public String getScrCompanyEmail() {
		return scrCompanyEmail;
	}

	public void setScrCompanyEmail(String scrCompanyEmail) {
		this.scrCompanyEmail = scrCompanyEmail;
	}
	
	@Length(min=0, max=2000, message="文件长度必须介于 0 和 2000 之间")
	public String getScrFiles() {
		return scrFiles;
	}

	public void setScrFiles(String scrFiles) {
		this.scrFiles = scrFiles;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="接受老师长度必须介于 0 和 64 之间")
	public String getScrRecTeachId() {
		return scrRecTeachId;
	}

	public void setScrRecTeachId(String scrRecTeachId) {
		this.scrRecTeachId = scrRecTeachId;
	}
	
	@Length(min=0, max=1000, message="接受意见长度必须介于 0 和 1000 之间")
	public String getScrRecComment() {
		return scrRecComment;
	}

	public void setScrRecComment(String scrRecComment) {
		this.scrRecComment = scrRecComment;
	}
	
	@Length(min=0, max=1000, message="完成意见长度必须介于 0 和 1000 之间")
	public String getScrFinalComment() {
		return scrFinalComment;
	}

	public void setScrFinalComment(String scrFinalComment) {
		this.scrFinalComment = scrFinalComment;
	}
	
}
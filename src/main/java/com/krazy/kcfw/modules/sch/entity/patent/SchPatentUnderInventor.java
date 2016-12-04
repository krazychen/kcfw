/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.patent;

import org.hibernate.validator.constraints.Length;


import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 发明专利（本科）Entity
 * @author Krazy
 * @version 2016-11-20
 */
public class SchPatentUnderInventor extends DataEntity<SchPatentUnderInventor> {
	
	private static final long serialVersionUID = 1L;
	private SchPatentUnder spiPatent;		// 专利ID 父类
	private String spiTypeCode;		// 发明人类型
	private String spiTypeName;		// 发明人类型名称
	private String spiUserId;		// 发明人学生姓名id
	private String spiUserName;		// 发明人学生姓名
	private String spiTeacherId;		// 发明人老师姓名id
	private String spiTeacherName;		// 发明人老师姓名
	private String spiUserNameEX;		// 发明人校外姓名
	private String spiUserOfficeId;		// 发明人学生单位代码
	private String spiUserOfficeName;		// 发明人学生单位
	private String spiTeacherOfficeId;		// 发明人教师单位代码
	private String spiTeacherOfficeName;		// 发明人教师单位
	private String spiOfficeNameEx;		//发明人校外单位
	private String spiContributionPer;		// 贡献度(%)
	private String spiRemark;		// 备注
	
	public SchPatentUnderInventor() {
		super();
	}

	public SchPatentUnderInventor(String id){
		super(id);
	}
	
	

	public String getSpiTeacherId() {
		return spiTeacherId;
	}

	public void setSpiTeacherId(String spiTeacherId) {
		this.spiTeacherId = spiTeacherId;
	}

	public String getSpiTeacherName() {
		return spiTeacherName;
	}

	public void setSpiTeacherName(String spiTeacherName) {
		this.spiTeacherName = spiTeacherName;
	}

	public String getSpiUserNameEX() {
		return spiUserNameEX;
	}

	public void setSpiUserNameEX(String spiUserNameEX) {
		this.spiUserNameEX = spiUserNameEX;
	}

	public SchPatentUnderInventor(SchPatentUnder spiPatent){
		this.spiPatent = spiPatent;
	}
	
	
	
	public String getSpiOfficeNameEx() {
		return spiOfficeNameEx;
	}

	public void setSpiOfficeNameEx(String spiOfficeNameEx) {
		this.spiOfficeNameEx = spiOfficeNameEx;
	}

	@Length(min=1, max=11, message="专利长度必须介于 1 和 11 之间")
	public SchPatentUnder getSpiPatent() {
		return spiPatent;
	}

	public void setSpiPatent(SchPatentUnder spiPatent) {
		this.spiPatent = spiPatent;
	}
	
	@Length(min=1, max=45, message="发明人类型长度必须介于 1 和 45 之间")
	public String getSpiTypeCode() {
		return spiTypeCode;
	}

	public void setSpiTypeCode(String spiTypeCode) {
		this.spiTypeCode = spiTypeCode;
	}
	
	@Length(min=1, max=45, message="发明人类型长度必须介于 1 和 45 之间")
	public String getSpiTypeName() {
		return spiTypeName;
	}

	public void setSpiTypeName(String spiTypeName) {
		this.spiTypeName = spiTypeName;
	}

	@Length(min=1, max=64, message="发明人姓名id长度必须介于 1 和 64 之间")
	public String getSpiUserId() {
		return spiUserId;
	}

	public void setSpiUserId(String spiUserId) {
		this.spiUserId = spiUserId;
	}
	
	@Length(min=1, max=45, message="发明人姓名长度必须介于 1 和 45 之间")
	public String getSpiUserName() {
		return spiUserName;
	}

	public void setSpiUserName(String spiUserName) {
		this.spiUserName = spiUserName;
	}
	
	@Length(min=1, max=64, message="发明人学生单位代码长度必须介于 1 和 64 之间")
	public String getSpiUserOfficeId() {
		return spiUserOfficeId;
	}

	public void setSpiUserOfficeId(String spiUserOfficeId) {
		this.spiUserOfficeId = spiUserOfficeId;
	}
	
	@Length(min=1, max=45, message="发明人学生单位长度必须介于 1 和 45 之间")
	public String getSpiUserOfficeName() {
		return spiUserOfficeName;
	}

	public void setSpiUserOfficeName(String spiUserOfficeName) {
		this.spiUserOfficeName = spiUserOfficeName;
	}
	
	@Length(min=1, max=64, message="发明人教师单位代码长度必须介于 1 和 64 之间")
	public String getSpiTeacherOfficeId() {
		return spiTeacherOfficeId;
	}

	public void setSpiTeacherOfficeId(String spiTeacherOfficeId) {
		this.spiTeacherOfficeId = spiTeacherOfficeId;
	}
	
	@Length(min=1, max=45, message="发明人教师单位长度必须介于 1 和 45 之间")
	public String getSpiTeacherOfficeName() {
		return spiTeacherOfficeName;
	}

	public void setSpiTeacherOfficeName(String spiTeacherOfficeName) {
		this.spiTeacherOfficeName = spiTeacherOfficeName;
	}
	@Length(min=1, max=11, message="贡献度(%)长度必须介于 1 和 11 之间")
	public String getSpiContributionPer() {
		return spiContributionPer;
	}

	public void setSpiContributionPer(String spiContributionPer) {
		this.spiContributionPer = spiContributionPer;
	}
	
	@Length(min=0, max=2000, message="备注长度必须介于 0 和 2000 之间")
	public String getSpiRemark() {
		return spiRemark;
	}

	public void setSpiRemark(String spiRemark) {
		this.spiRemark = spiRemark;
	}
	
}
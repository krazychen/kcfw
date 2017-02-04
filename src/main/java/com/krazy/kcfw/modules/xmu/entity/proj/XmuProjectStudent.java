/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.proj;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目人员Entity
 * @author Krazy
 * @version 2017-02-03
 */
public class XmuProjectStudent extends DataEntity<XmuProjectStudent> {
	
	private static final long serialVersionUID = 1L;
	private String xpsProjId;		// 项目ID
	private String xpsOfficeId;		// 学生学院ID
	private String xpsOfficeName;		// 学院
	private String xpsUserId;		// 学生ID
	private String xpsUserName;		// 姓名
	private String xpuUserGrade;		// 年级
	private String xpuUserProfession;		// 专业
	private String xpuUserStuno;		// 学号
	private String xpuUserLincno;		// 证件号
	private String xpuUserMidsch;		// 毕业中学
	private Date xpuUserGradTime;		// 毕业时间
	private String xpuUserGradAdd;		// 毕业去向
	private String xpuUserGraduteSch;		// 读研学校
	private String xpuUserGraduteProf;		// 读研专业
	private String xpuUserWork;		// 工作单位
	private String xpuUserRemark;		// 待定说明
	private String xpuUserTeacher;		// 导师
	private String xpuUserTeacherJobtitle;		// 职称
	private String xpuUserTeacherTitle;		// 头衔
	private Date xpuUserRegTime;		// 入选时间
	private Date xpuUserExitTime;		// 退出时间
	private String xpuUserStatus;		// 状态:正常、离开、空
	
	public XmuProjectStudent() {
		super();
	}

	public XmuProjectStudent(String id){
		super(id);
	}

	@Length(min=1, max=200, message="项目ID长度必须介于 1 和 200 之间")
	@ExcelField(title="项目ID", align=2, sort=6)
	public String getXpsProjId() {
		return xpsProjId;
	}

	public void setXpsProjId(String xpsProjId) {
		this.xpsProjId = xpsProjId;
	}
	
	@Length(min=1, max=64, message="学生学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学生学院ID", align=2, sort=7)
	public String getXpsOfficeId() {
		return xpsOfficeId;
	}

	public void setXpsOfficeId(String xpsOfficeId) {
		this.xpsOfficeId = xpsOfficeId;
	}
	
	@Length(min=1, max=64, message="学院长度必须介于 1 和 64 之间")
	@ExcelField(title="学院", align=2, sort=8)
	public String getXpsOfficeName() {
		return xpsOfficeName;
	}

	public void setXpsOfficeName(String xpsOfficeName) {
		this.xpsOfficeName = xpsOfficeName;
	}
	
	@Length(min=1, max=2000, message="学生ID长度必须介于 1 和 2000 之间")
	@ExcelField(title="学生ID", align=2, sort=9)
	public String getXpsUserId() {
		return xpsUserId;
	}

	public void setXpsUserId(String xpsUserId) {
		this.xpsUserId = xpsUserId;
	}
	
	@Length(min=1, max=2000, message="姓名长度必须介于 1 和 2000 之间")
	@ExcelField(title="姓名", align=2, sort=10)
	public String getXpsUserName() {
		return xpsUserName;
	}

	public void setXpsUserName(String xpsUserName) {
		this.xpsUserName = xpsUserName;
	}
	
	@Length(min=0, max=64, message="年级长度必须介于 0 和 64 之间")
	@ExcelField(title="年级", align=2, sort=11)
	public String getXpuUserGrade() {
		return xpuUserGrade;
	}

	public void setXpuUserGrade(String xpuUserGrade) {
		this.xpuUserGrade = xpuUserGrade;
	}
	
	@Length(min=0, max=64, message="专业长度必须介于 0 和 64 之间")
	@ExcelField(title="专业", align=2, sort=12)
	public String getXpuUserProfession() {
		return xpuUserProfession;
	}

	public void setXpuUserProfession(String xpuUserProfession) {
		this.xpuUserProfession = xpuUserProfession;
	}
	
	@Length(min=0, max=64, message="学号长度必须介于 0 和 64 之间")
	@ExcelField(title="学号", align=2, sort=13)
	public String getXpuUserStuno() {
		return xpuUserStuno;
	}

	public void setXpuUserStuno(String xpuUserStuno) {
		this.xpuUserStuno = xpuUserStuno;
	}
	
	@Length(min=0, max=64, message="证件号长度必须介于 0 和 64 之间")
	@ExcelField(title="证件号", align=2, sort=14)
	public String getXpuUserLincno() {
		return xpuUserLincno;
	}

	public void setXpuUserLincno(String xpuUserLincno) {
		this.xpuUserLincno = xpuUserLincno;
	}
	
	@Length(min=0, max=64, message="毕业中学长度必须介于 0 和 64 之间")
	@ExcelField(title="毕业中学", align=2, sort=15)
	public String getXpuUserMidsch() {
		return xpuUserMidsch;
	}

	public void setXpuUserMidsch(String xpuUserMidsch) {
		this.xpuUserMidsch = xpuUserMidsch;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="毕业时间", align=2, sort=16)
	public Date getXpuUserGradTime() {
		return xpuUserGradTime;
	}

	public void setXpuUserGradTime(Date xpuUserGradTime) {
		this.xpuUserGradTime = xpuUserGradTime;
	}
	
	@Length(min=0, max=64, message="毕业去向长度必须介于 0 和 64 之间")
	@ExcelField(title="毕业去向", dictType="XMU_PROJECT_STU_GRAD_ADD", align=2, sort=17)
	public String getXpuUserGradAdd() {
		return xpuUserGradAdd;
	}

	public void setXpuUserGradAdd(String xpuUserGradAdd) {
		this.xpuUserGradAdd = xpuUserGradAdd;
	}
	
	@Length(min=0, max=64, message="读研学校长度必须介于 0 和 64 之间")
	@ExcelField(title="读研学校", align=2, sort=18)
	public String getXpuUserGraduteSch() {
		return xpuUserGraduteSch;
	}

	public void setXpuUserGraduteSch(String xpuUserGraduteSch) {
		this.xpuUserGraduteSch = xpuUserGraduteSch;
	}
	
	@Length(min=0, max=64, message="读研专业长度必须介于 0 和 64 之间")
	@ExcelField(title="读研专业", align=2, sort=19)
	public String getXpuUserGraduteProf() {
		return xpuUserGraduteProf;
	}

	public void setXpuUserGraduteProf(String xpuUserGraduteProf) {
		this.xpuUserGraduteProf = xpuUserGraduteProf;
	}
	
	@Length(min=0, max=64, message="工作单位长度必须介于 0 和 64 之间")
	@ExcelField(title="工作单位", align=2, sort=20)
	public String getXpuUserWork() {
		return xpuUserWork;
	}

	public void setXpuUserWork(String xpuUserWork) {
		this.xpuUserWork = xpuUserWork;
	}
	
	@Length(min=0, max=2000, message="待定说明长度必须介于 0 和 2000 之间")
	@ExcelField(title="待定说明", align=2, sort=21)
	public String getXpuUserRemark() {
		return xpuUserRemark;
	}

	public void setXpuUserRemark(String xpuUserRemark) {
		this.xpuUserRemark = xpuUserRemark;
	}
	
	@Length(min=0, max=64, message="导师长度必须介于 0 和 64 之间")
	@ExcelField(title="导师", align=2, sort=22)
	public String getXpuUserTeacher() {
		return xpuUserTeacher;
	}

	public void setXpuUserTeacher(String xpuUserTeacher) {
		this.xpuUserTeacher = xpuUserTeacher;
	}
	
	@Length(min=0, max=64, message="职称长度必须介于 0 和 64 之间")
	@ExcelField(title="职称", dictType="XMU_PROJECT_STU_TEA_JOBTITLE", align=2, sort=23)
	public String getXpuUserTeacherJobtitle() {
		return xpuUserTeacherJobtitle;
	}

	public void setXpuUserTeacherJobtitle(String xpuUserTeacherJobtitle) {
		this.xpuUserTeacherJobtitle = xpuUserTeacherJobtitle;
	}
	
	@Length(min=0, max=64, message="头衔长度必须介于 0 和 64 之间")
	@ExcelField(title="头衔", dictType="XMU_PROJECT_STU_TEA_TITLE", align=2, sort=24)
	public String getXpuUserTeacherTitle() {
		return xpuUserTeacherTitle;
	}

	public void setXpuUserTeacherTitle(String xpuUserTeacherTitle) {
		this.xpuUserTeacherTitle = xpuUserTeacherTitle;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="入选时间", align=2, sort=25)
	public Date getXpuUserRegTime() {
		return xpuUserRegTime;
	}

	public void setXpuUserRegTime(Date xpuUserRegTime) {
		this.xpuUserRegTime = xpuUserRegTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="退出时间", align=2, sort=26)
	public Date getXpuUserExitTime() {
		return xpuUserExitTime;
	}

	public void setXpuUserExitTime(Date xpuUserExitTime) {
		this.xpuUserExitTime = xpuUserExitTime;
	}
	
	@Length(min=0, max=64, message="状态:正常、离开、空长度必须介于 0 和 64 之间")
	@ExcelField(title="状态:正常、离开、空", dictType="XMU_PROJECT_STU_STATUS", align=2, sort=27)
	public String getXpuUserStatus() {
		return xpuUserStatus;
	}

	public void setXpuUserStatus(String xpuUserStatus) {
		this.xpuUserStatus = xpuUserStatus;
	}
	
}
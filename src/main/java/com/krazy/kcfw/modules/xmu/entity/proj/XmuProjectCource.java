/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.proj;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目课程Entity
 * @author Krazy
 * @version 2017-02-06
 */
public class XmuProjectCource extends DataEntity<XmuProjectCource> {
	
	private static final long serialVersionUID = 1L;
	private String xpcOfficeName;		// 学院名称
	private String xpcProjName;		// 项目名称
	private String xpcCourseType;		// 课程类型
	private String xciCourseGrade;		// 开课年级
	private String xciCourseSemester;		// 开课学期
	private String xpcCourseLang;		// 授课语言
	private String xpcProjId;		// 项目ID
	private String xpcCourseUnit;		// 开课单位
	private String xpcCourseName;		// 课程名称
	private String xciCourseHours;		// 学时
	private String xciCourseCredit;		// 学分
	private String xpcOfficeId;		// 学院ID
	private String xciCourseSemesterNew; //拟开课学期
	private List courseIdList;
	private String xpcCourseInfoId;
	
	/**
	 * @return the xciCourseSemesterNew
	 */
	public String getXciCourseSemesterNew() {
		return xciCourseSemesterNew;
	}

	/**
	 * @param xciCourseSemesterNew the xciCourseSemesterNew to set
	 */
	public void setXciCourseSemesterNew(String xciCourseSemesterNew) {
		this.xciCourseSemesterNew = xciCourseSemesterNew;
	}

	/**
	 * @return the xpcCourseInfoId
	 */
	public String getXpcCourseInfoId() {
		return xpcCourseInfoId;
	}

	/**
	 * @param xpcCourseInfoId the xpcCourseInfoId to set
	 */
	public void setXpcCourseInfoId(String xpcCourseInfoId) {
		this.xpcCourseInfoId = xpcCourseInfoId;
	}

	/**
	 * @return the courseIdList
	 */
	public List getCourseIdList() {
		return courseIdList;
	}

	/**
	 * @param courseIdList the courseIdList to set
	 */
	public void setCourseIdList(List courseIdList) {
		this.courseIdList = courseIdList;
	}

	public XmuProjectCource() {
		super();
	}

	public XmuProjectCource(String id){
		super(id);
	}

	@Length(min=0, max=200, message="学院名称长度必须介于 0 和 200 之间")
	@ExcelField(title="学院名称", type=0,fieldType=String.class, value="", align=2, sort=1)
	public String getXpcOfficeName() {
		return xpcOfficeName;
	}

	public void setXpcOfficeName(String xpcOfficeName) {
		this.xpcOfficeName = xpcOfficeName;
	}
	
	@Length(min=0, max=200, message="项目名称长度必须介于 0 和 200 之间")
	@ExcelField(title="项目名称",type=0, align=2, sort=3)
	public String getXpcProjName() {
		return xpcProjName;
	}

	public void setXpcProjName(String xpcProjName) {
		this.xpcProjName = xpcProjName;
	}
	
	@Length(min=0, max=64, message="课程类型长度必须介于 0 和 64 之间")
	@ExcelField(title="课程类型",type=0, align=2, sort=4)
	public String getXpcCourseType() {
		return xpcCourseType;
	}

	public void setXpcCourseType(String xpcCourseType) {
		this.xpcCourseType = xpcCourseType;
	}
	
	@Length(min=0, max=64, message="开课年级长度必须介于 0 和 64 之间")
	@ExcelField(title="开课年级",type=0, align=2, sort=5)
	public String getXciCourseGrade() {
		return xciCourseGrade;
	}

	public void setXciCourseGrade(String xciCourseGrade) {
		this.xciCourseGrade = xciCourseGrade;
	}
	
	@Length(min=0, max=64, message="开课学期长度必须介于 0 和 64 之间")
	@ExcelField(title="开课学期",type=0, align=2, sort=6)
	public String getXciCourseSemester() {
		return xciCourseSemester;
	}

	public void setXciCourseSemester(String xciCourseSemester) {
		this.xciCourseSemester = xciCourseSemester;
	}
	
	@Length(min=0, max=64, message="授课语言长度必须介于 0 和 64 之间")
	@ExcelField(title="授课语言",type=0, align=2, sort=7)
	public String getXpcCourseLang() {
		return xpcCourseLang;
	}

	public void setXpcCourseLang(String xpcCourseLang) {
		this.xpcCourseLang = xpcCourseLang;
	}
	
	@Length(min=1, max=200, message="项目ID长度必须介于 1 和 200 之间")
	@ExcelField(title="项目ID",type=0, align=2, sort=2)
	public String getXpcProjId() {
		return xpcProjId;
	}

	public void setXpcProjId(String xpcProjId) {
		this.xpcProjId = xpcProjId;
	}
	
	@Length(min=0, max=64, message="开课单位长度必须介于 0 和 64 之间")
	@ExcelField(title="开课单位",type=0, align=2, sort=8)
	public String getXpcCourseUnit() {
		return xpcCourseUnit;
	}

	public void setXpcCourseUnit(String xpcCourseUnit) {
		this.xpcCourseUnit = xpcCourseUnit;
	}
	
	@Length(min=0, max=64, message="课程名称长度必须介于 0 和 64 之间")
	@ExcelField(title="课程名称",type=0, align=2, sort=9)
	public String getXpcCourseName() {
		return xpcCourseName;
	}

	public void setXpcCourseName(String xpcCourseName) {
		this.xpcCourseName = xpcCourseName;
	}
	
	@Length(min=0, max=64, message="学时长度必须介于 0 和 64 之间")
	@ExcelField(title="学时",type=0, align=2, sort=10)
	public String getXciCourseHours() {
		return xciCourseHours;
	}

	public void setXciCourseHours(String xciCourseHours) {
		this.xciCourseHours = xciCourseHours;
	}
	
	@Length(min=0, max=64, message="学分长度必须介于 0 和 64 之间")
	@ExcelField(title="学分",type=0, align=2, sort=11)
	public String getXciCourseCredit() {
		return xciCourseCredit;
	}

	public void setXciCourseCredit(String xciCourseCredit) {
		this.xciCourseCredit = xciCourseCredit;
	}
	
	@Length(min=0, max=64, message="学院ID长度必须介于 0 和 64 之间")
	@ExcelField(title="学院ID",type=0, align=2, sort=0)
	public String getXpcOfficeId() {
		return xpcOfficeId;
	}

	public void setXpcOfficeId(String xpcOfficeId) {
		this.xpcOfficeId = xpcOfficeId;
	}
	
}
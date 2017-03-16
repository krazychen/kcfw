/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.proj;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目开课Entity
 * @author Krazy
 * @version 2017-02-13
 */
public class XmuProjectTeaching extends DataEntity<XmuProjectTeaching> {
	
	private static final long serialVersionUID = 1L;
	private String xptProjName;		// 项目名称
	private String xptProjLevel;		// 项目级别
	private String xptTeachingName;		// 课程名称
	private String xptTeachingLang;		// 授课语言
	private String xptTeachingOffice;		// 学院
	private String xptTeachingGrade;		// 学年学期
	private String xptProjId;		// 项目ID
	private String xptOfficeId;		// 学院ID
	private String xptOfficeName;		// 学院名称
	private String xptTeachingInfoId;		// 课程ID
	private String xptTeachingProfeesion;		// 专业
	private String xptTeachingHours;		// 总学时
	private String xptTeachingStu;		// 上课人数
	private String xptTeachingTeacher;		// 主讲老师
	private String xptTeachingJobtitle;		// 职称
	private String xptTeachingTitle;		// 头衔
	private List teachingIdList;
	
	
	
	/**
	 * @return the teachingIdList
	 */
	public List getTeachingIdList() {
		return teachingIdList;
	}

	/**
	 * @param teachingIdList the teachingIdList to set
	 */
	public void setTeachingIdList(List teachingIdList) {
		this.teachingIdList = teachingIdList;
	}

	public XmuProjectTeaching() {
		super();
	}

	public XmuProjectTeaching(String id){
		super(id);
	}

	@Length(min=0, max=200, message="项目名称长度必须介于 0 和 200 之间")
	@ExcelField(title="项目名称", align=2, sort=0)
	public String getXptProjName() {
		return xptProjName;
	}

	public void setXptProjName(String xptProjName) {
		this.xptProjName = xptProjName;
	}
	
	@Length(min=0, max=64, message="项目级别长度必须介于 0 和 64 之间")
	@ExcelField(title="项目级别", dictType="XMU_PROJECT_LEVEL", align=2, sort=1)
	public String getXptProjLevel() {
		return xptProjLevel;
	}

	public void setXptProjLevel(String xptProjLevel) {
		this.xptProjLevel = xptProjLevel;
	}
	
	@Length(min=0, max=200, message="课程名称长度必须介于 0 和 200 之间")
	@ExcelField(title="课程名称", align=2, sort=2)
	public String getXptTeachingName() {
		return xptTeachingName;
	}

	public void setXptTeachingName(String xptTeachingName) {
		this.xptTeachingName = xptTeachingName;
	}
	
	@Length(min=0, max=64, message="授课语言长度必须介于 0 和 64 之间")
	@ExcelField(title="授课语言", dictType="XMU_PROJECT_COR_LANG", align=2, sort=3)
	public String getXptTeachingLang() {
		return xptTeachingLang;
	}

	public void setXptTeachingLang(String xptTeachingLang) {
		this.xptTeachingLang = xptTeachingLang;
	}
	
	@Length(min=0, max=200, message="学院长度必须介于 0 和 200 之间")
	@ExcelField(title="学院", align=2, sort=4)
	public String getXptTeachingOffice() {
		return xptTeachingOffice;
	}

	public void setXptTeachingOffice(String xptTeachingOffice) {
		this.xptTeachingOffice = xptTeachingOffice;
	}
	
	@Length(min=0, max=200, message="学年学期长度必须介于 0 和 200 之间")
	@ExcelField(title="学年学期", align=2, sort=5)
	public String getXptTeachingGrade() {
		return xptTeachingGrade;
	}

	public void setXptTeachingGrade(String xptTeachingGrade) {
		this.xptTeachingGrade = xptTeachingGrade;
	}
	
	@Length(min=1, max=64, message="项目ID长度必须介于 1 和 64 之间")
	//@ExcelField(title="项目ID", align=2, sort=12)
	public String getXptProjId() {
		return xptProjId;
	}

	public void setXptProjId(String xptProjId) {
		this.xptProjId = xptProjId;
	}
	
	@Length(min=0, max=64, message="学院ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="学院ID", align=2, sort=13)
	public String getXptOfficeId() {
		return xptOfficeId;
	}

	public void setXptOfficeId(String xptOfficeId) {
		this.xptOfficeId = xptOfficeId;
	}
	
	@Length(min=0, max=200, message="学院名称长度必须介于 0 和 200 之间")
	@ExcelField(title="学院名称", align=2, sort=14)
	public String getXptOfficeName() {
		return xptOfficeName;
	}

	public void setXptOfficeName(String xptOfficeName) {
		this.xptOfficeName = xptOfficeName;
	}
	
	//@ExcelField(title="课程ID", align=2, sort=15)
	public String getXptTeachingInfoId() {
		return xptTeachingInfoId;
	}

	public void setXptTeachingInfoId(String xptTeachingInfoId) {
		this.xptTeachingInfoId = xptTeachingInfoId;
	}
	
	@Length(min=0, max=200, message="专业长度必须介于 0 和 200 之间")
	@ExcelField(title="专业", align=2, sort=16)
	public String getXptTeachingProfeesion() {
		return xptTeachingProfeesion;
	}

	public void setXptTeachingProfeesion(String xptTeachingProfeesion) {
		this.xptTeachingProfeesion = xptTeachingProfeesion;
	}
	
	@Length(min=0, max=64, message="总学时长度必须介于 0 和 64 之间")
	@ExcelField(title="总学时", align=2, sort=17)
	public String getXptTeachingHours() {
		return xptTeachingHours;
	}

	public void setXptTeachingHours(String xptTeachingHours) {
		this.xptTeachingHours = xptTeachingHours;
	}
	
	@Length(min=0, max=64, message="上课人数长度必须介于 0 和 64 之间")
	@ExcelField(title="上课人数", align=2, sort=18)
	public String getXptTeachingStu() {
		return xptTeachingStu;
	}

	public void setXptTeachingStu(String xptTeachingStu) {
		this.xptTeachingStu = xptTeachingStu;
	}
	
	@Length(min=0, max=200, message="主讲老师长度必须介于 0 和 200 之间")
	@ExcelField(title="主讲老师", align=2, sort=19)
	public String getXptTeachingTeacher() {
		return xptTeachingTeacher;
	}

	public void setXptTeachingTeacher(String xptTeachingTeacher) {
		this.xptTeachingTeacher = xptTeachingTeacher;
	}
	
	@Length(min=0, max=64, message="职称长度必须介于 0 和 64 之间")
	@ExcelField(title="职称", dictType="XMU_PROJECT_STU_TEA_JOBTITLE", align=2, sort=20)
	public String getXptTeachingJobtitle() {
		return xptTeachingJobtitle;
	}

	public void setXptTeachingJobtitle(String xptTeachingJobtitle) {
		this.xptTeachingJobtitle = xptTeachingJobtitle;
	}
	
	@Length(min=0, max=64, message="头衔长度必须介于 0 和 64 之间")
	@ExcelField(title="头衔", dictType="XMU_PROJECT_STU_TEA_TITLE", align=2, sort=21)
	public String getXptTeachingTitle() {
		return xptTeachingTitle;
	}

	public void setXptTeachingTitle(String xptTeachingTitle) {
		this.xptTeachingTitle = xptTeachingTitle;
	}
	
}
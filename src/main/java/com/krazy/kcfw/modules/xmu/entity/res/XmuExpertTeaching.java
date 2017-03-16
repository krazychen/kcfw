/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.res;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 专家授课Entity
 * @author Krazy
 * @version 2017-02-14
 */
public class XmuExpertTeaching extends DataEntity<XmuExpertTeaching> {
	
	private static final long serialVersionUID = 1L;
	private String xetProjName;		// 项目名称
	private String xetExpretOffice;		// 学院
	private String xetExpertProfession;		// 专业
	private String xetExpertGrade;		// 学年学期
	private String xetExpertName;		// 姓名
	private String xetProjId;		// 项目ID
	private String xetExpertCourseName;		// 课程名称
	private String xetExpertHours;		// 学时
	private String xetExpertAreaId;		// 国家或地区ID
	private String xetExpertArea;		// 国家或地区
	private String xetExpertUnit;		// 单位
	private String xetExpertJobTitle;		// 职称
	private String xetExpertTitle;		// 头衔
	private String xetExpretOfficeId;		// 学院ID
	
	public XmuExpertTeaching() {
		super();
	}

	public XmuExpertTeaching(String id){
		super(id);
	}
	
	/**
	 * @return the xetExpertAreaId
	 */
	public String getXetExpertAreaId() {
		return xetExpertAreaId;
	}

	/**
	 * @param xetExpertAreaId the xetExpertAreaId to set
	 */
	public void setXetExpertAreaId(String xetExpertAreaId) {
		this.xetExpertAreaId = xetExpertAreaId;
	}

	@Length(min=0, max=200, message="项目名称长度必须介于 0 和 200 之间")
	@ExcelField(title="项目名称", align=2, sort=0)
	public String getXetProjName() {
		return xetProjName;
	}

	public void setXetProjName(String xetProjName) {
		this.xetProjName = xetProjName;
	}
	
	@Length(min=0, max=200, message="学院长度必须介于 0 和 200 之间")
	@ExcelField(title="学院", fieldType=String.class, value="", align=2, sort=1)
	public String getXetExpretOffice() {
		return xetExpretOffice;
	}

	public void setXetExpretOffice(String xetExpretOffice) {
		this.xetExpretOffice = xetExpretOffice;
	}
	
	@Length(min=0, max=64, message="专业长度必须介于 0 和 64 之间")
	@ExcelField(title="专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=2)
	public String getXetExpertProfession() {
		return xetExpertProfession;
	}

	public void setXetExpertProfession(String xetExpertProfession) {
		this.xetExpertProfession = xetExpertProfession;
	}
	
	@Length(min=0, max=64, message="学年学期长度必须介于 0 和 64 之间")
	@ExcelField(title="学年学期", dictType="XMU_PROJECT_COR_GRADE", align=2, sort=3)
	public String getXetExpertGrade() {
		return xetExpertGrade;
	}

	public void setXetExpertGrade(String xetExpertGrade) {
		this.xetExpertGrade = xetExpertGrade;
	}
	
	@Length(min=0, max=200, message="姓名长度必须介于 0 和 200 之间")
	@ExcelField(title="姓名", align=2, sort=4)
	public String getXetExpertName() {
		return xetExpertName;
	}

	public void setXetExpertName(String xetExpertName) {
		this.xetExpertName = xetExpertName;
	}
	
	@Length(min=0, max=64, message="项目ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="项目ID", align=2, sort=11)
	public String getXetProjId() {
		return xetProjId;
	}

	public void setXetProjId(String xetProjId) {
		this.xetProjId = xetProjId;
	}
	
	@Length(min=0, max=200, message="课程名称长度必须介于 0 和 200 之间")
	@ExcelField(title="课程名称", align=2, sort=12)
	public String getXetExpertCourseName() {
		return xetExpertCourseName;
	}

	public void setXetExpertCourseName(String xetExpertCourseName) {
		this.xetExpertCourseName = xetExpertCourseName;
	}
	
	@Length(min=0, max=64, message="学时长度必须介于 0 和 64 之间")
	@ExcelField(title="学时", align=2, sort=13)
	public String getXetExpertHours() {
		return xetExpertHours;
	}

	public void setXetExpertHours(String xetExpertHours) {
		this.xetExpertHours = xetExpertHours;
	}
	
	@Length(min=0, max=64, message="国家或地区长度必须介于 0 和 64 之间")
	@ExcelField(title="国家或地区", fieldType=String.class, value="", align=2, sort=14)
	public String getXetExpertArea() {
		return xetExpertArea;
	}

	public void setXetExpertArea(String xetExpertArea) {
		this.xetExpertArea = xetExpertArea;
	}
	
	@Length(min=0, max=200, message="单位长度必须介于 0 和 200 之间")
	@ExcelField(title="单位", align=2, sort=15)
	public String getXetExpertUnit() {
		return xetExpertUnit;
	}

	public void setXetExpertUnit(String xetExpertUnit) {
		this.xetExpertUnit = xetExpertUnit;
	}
	
	@Length(min=0, max=64, message="职称长度必须介于 0 和 64 之间")
	@ExcelField(title="职称", dictType="XMU_PROJECT_STU_TEA_JOBTITLE", align=2, sort=16)
	public String getXetExpertJobTitle() {
		return xetExpertJobTitle;
	}

	public void setXetExpertJobTitle(String xetExpertJobTitle) {
		this.xetExpertJobTitle = xetExpertJobTitle;
	}
	
	@Length(min=0, max=64, message="头衔长度必须介于 0 和 64 之间")
	@ExcelField(title="头衔", dictType="XMU_PROJECT_STU_TEA_TITLE", align=2, sort=17)
	public String getXetExpertTitle() {
		return xetExpertTitle;
	}

	public void setXetExpertTitle(String xetExpertTitle) {
		this.xetExpertTitle = xetExpertTitle;
	}
	
	@Length(min=0, max=64, message="学院ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="学院ID", align=2, sort=18)
	public String getXetExpretOfficeId() {
		return xetExpretOfficeId;
	}

	public void setXetExpretOfficeId(String xetExpretOfficeId) {
		this.xetExpretOfficeId = xetExpretOfficeId;
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.res;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 专家讲座Entity
 * @author Krazy
 * @version 2017-02-14
 */
public class XmuExpertLecture extends DataEntity<XmuExpertLecture> {
	
	private static final long serialVersionUID = 1L;
	private String xelProjName;		// 项目名称
	private String xelExpretOffice;		// 学院
	private String xelExpertProfession;		// 专业
	private String xelExpertName;		// 姓名
	private String xelExpertTitle;		// 头衔
	private String xelProjId;		// 项目ID
	private String xelExpertGrade;		// 学年学期
	private String xelExpertLectureName;		// 讲座名称
	private String xelExpertArea;		// 地区
	private String xelExpertUnit;		// 单位
	private String xelExpertJobTitle;		// 职称
	private String xelExpretOfficeId;		// 学院ID
	private String xelExpertAreaId;		// 地区ID
	private String xelExpertTitleStr;	
	
	
	
	/**
	 * @return the xelExpertTitleStr
	 */
	public String getXelExpertTitleStr() {
		return xelExpertTitleStr;
	}

	/**
	 * @param xelExpertTitleStr the xelExpertTitleStr to set
	 */
	public void setXelExpertTitleStr(String xelExpertTitleStr) {
		this.xelExpertTitleStr = xelExpertTitleStr;
	}

	public XmuExpertLecture() {
		super();
	}

	public XmuExpertLecture(String id){
		super(id);
	}

	@Length(min=0, max=200, message="项目名称长度必须介于 0 和 200 之间")
	@ExcelField(title="项目名称", align=2, sort=0)
	public String getXelProjName() {
		return xelProjName;
	}

	public void setXelProjName(String xelProjName) {
		this.xelProjName = xelProjName;
	}
	
	@Length(min=0, max=200, message="学院长度必须介于 0 和 200 之间")
	@ExcelField(title="学院", fieldType=String.class, value="", align=2, sort=1)
	public String getXelExpretOffice() {
		return xelExpretOffice;
	}

	public void setXelExpretOffice(String xelExpretOffice) {
		this.xelExpretOffice = xelExpretOffice;
	}
	
	@Length(min=0, max=64, message="专业长度必须介于 0 和 64 之间")
	@ExcelField(title="专业", dictType="XMU_PROJECT_COR_PROFESSION", align=2, sort=2)
	public String getXelExpertProfession() {
		return xelExpertProfession;
	}

	public void setXelExpertProfession(String xelExpertProfession) {
		this.xelExpertProfession = xelExpertProfession;
	}
	
	@Length(min=0, max=200, message="姓名长度必须介于 0 和 200 之间")
	@ExcelField(title="姓名", align=2, sort=3)
	public String getXelExpertName() {
		return xelExpertName;
	}

	public void setXelExpertName(String xelExpertName) {
		this.xelExpertName = xelExpertName;
	}
	
	@Length(min=0, max=64, message="头衔长度必须介于 0 和 64 之间")
	@ExcelField(title="头衔", dictType="XMU_PROJECT_STU_TEA_TITLE", align=2, sort=4)
	public String getXelExpertTitle() {
		return xelExpertTitle;
	}

	public void setXelExpertTitle(String xelExpertTitle) {
		this.xelExpertTitle = xelExpertTitle;
	}
	
	@Length(min=0, max=64, message="项目ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="项目ID", align=2, sort=11)
	public String getXelProjId() {
		return xelProjId;
	}

	public void setXelProjId(String xelProjId) {
		this.xelProjId = xelProjId;
	}
	
	@Length(min=0, max=64, message="学年学期长度必须介于 0 和 64 之间")
	@ExcelField(title="学年学期", dictType="XMU_PROJECT_COR_GRADE", align=2, sort=12)
	public String getXelExpertGrade() {
		return xelExpertGrade;
	}

	public void setXelExpertGrade(String xelExpertGrade) {
		this.xelExpertGrade = xelExpertGrade;
	}
	
	@Length(min=0, max=200, message="讲座名称长度必须介于 0 和 200 之间")
	@ExcelField(title="讲座名称", align=2, sort=13)
	public String getXelExpertLectureName() {
		return xelExpertLectureName;
	}

	public void setXelExpertLectureName(String xelExpertLectureName) {
		this.xelExpertLectureName = xelExpertLectureName;
	}
	
	@Length(min=0, max=200, message="地区长度必须介于 0 和 200 之间")
	@ExcelField(title="地区", fieldType=String.class, value="", align=2, sort=14)
	public String getXelExpertArea() {
		return xelExpertArea;
	}

	public void setXelExpertArea(String xelExpertArea) {
		this.xelExpertArea = xelExpertArea;
	}
	
	@Length(min=0, max=200, message="单位长度必须介于 0 和 200 之间")
	@ExcelField(title="单位", align=2, sort=15)
	public String getXelExpertUnit() {
		return xelExpertUnit;
	}

	public void setXelExpertUnit(String xelExpertUnit) {
		this.xelExpertUnit = xelExpertUnit;
	}
	
	@Length(min=0, max=64, message="职称长度必须介于 0 和 64 之间")
	@ExcelField(title="职称", dictType="XMU_PROJECT_STU_TEA_JOBTITLE", align=2, sort=16)
	public String getXelExpertJobTitle() {
		return xelExpertJobTitle;
	}

	public void setXelExpertJobTitle(String xelExpertJobTitle) {
		this.xelExpertJobTitle = xelExpertJobTitle;
	}
	
	@Length(min=0, max=64, message="学院ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="学院ID", align=2, sort=17)
	public String getXelExpretOfficeId() {
		return xelExpretOfficeId;
	}

	public void setXelExpretOfficeId(String xelExpretOfficeId) {
		this.xelExpretOfficeId = xelExpretOfficeId;
	}
	
	@Length(min=0, max=64, message="地区ID长度必须介于 0 和 64 之间")
	//@ExcelField(title="地区ID", align=2, sort=18)
	public String getXelExpertAreaId() {
		return xelExpertAreaId;
	}

	public void setXelExpertAreaId(String xelExpertAreaId) {
		this.xelExpertAreaId = xelExpertAreaId;
	}
	
}
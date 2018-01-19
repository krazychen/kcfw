/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.rep;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目汇报管理Entity
 * @author Krazy
 * @version 2017-06-03
 */
public class XmuReportMnt extends ActEntity<XmuReportMnt> {
	
	private static final long serialVersionUID = 1L;
	private String xrmMonths;		// 年份
	private String xrmOfficeId;		// 学院ID
	private String xrmProjId;		// 项目ID
	private String xrmProjName;		// 项目名称
	private String xrmOfficeName;		// 学院名称
	private String xrmDescp;		// 汇报说明
	private String xrmFiles;		// 附件
	private String procInsId;		// 流程实例ID
	private String xrmStatus;		// 活动状态
	private String xrmCollegeComment;		// 院系管理员审核意见
	private String xrmManageComment;		// 系统管理员审核意见
	private String xrmCollegeStandby;		// 待审院系管理员
	private String xrmManageStandby;		// 待审系统管理员
	private String xrmTemplate;		// 附件
	private String urlType;

	/**
	 * @return the urlType
	 */
	public String getUrlType() {
		return urlType;
	}

	/**
	 * @param urlType the urlType to set
	 */
	public void setUrlType(String urlType) {
		this.urlType = urlType;
	}

	
	
	/**
	 * @return the xrmTemplate
	 */
	public String getXrmTemplate() {
		return xrmTemplate;
	}

	/**
	 * @param xrmTemplate the xrmTemplate to set
	 */
	public void setXrmTemplate(String xrmTemplate) {
		this.xrmTemplate = xrmTemplate;
	}

	public XmuReportMnt() {
		super();
	}

	public XmuReportMnt(String id){
		super(id);
	}

	@Length(min=0, max=64, message="年份长度必须介于 0 和 64 之间")
	@ExcelField(title="年份", align=2, sort=0)
	public String getXrmMonths() {
		return xrmMonths;
	}

	public void setXrmMonths(String xrmMonths) {
		this.xrmMonths = xrmMonths;
	}
	
	@Length(min=1, max=64, message="学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学院ID", fieldType=String.class, value="", align=2, sort=1)
	public String getXrmOfficeId() {
		return xrmOfficeId;
	}

	public void setXrmOfficeId(String xrmOfficeId) {
		this.xrmOfficeId = xrmOfficeId;
	}
	
	@Length(min=0, max=200, message="项目ID长度必须介于 0 和 200 之间")
	@ExcelField(title="项目ID", align=2, sort=2)
	public String getXrmProjId() {
		return xrmProjId;
	}

	public void setXrmProjId(String xrmProjId) {
		this.xrmProjId = xrmProjId;
	}
	
	@Length(min=0, max=64, message="项目名称长度必须介于 0 和 64 之间")
	@ExcelField(title="项目名称", align=2, sort=9)
	public String getXrmProjName() {
		return xrmProjName;
	}

	public void setXrmProjName(String xrmProjName) {
		this.xrmProjName = xrmProjName;
	}
	
	@Length(min=1, max=200, message="学院名称长度必须介于 1 和 200 之间")
	@ExcelField(title="学院名称", align=2, sort=10)
	public String getXrmOfficeName() {
		return xrmOfficeName;
	}

	public void setXrmOfficeName(String xrmOfficeName) {
		this.xrmOfficeName = xrmOfficeName;
	}
	
	@Length(min=0, max=2000, message="汇报说明长度必须介于 0 和 2000 之间")
	@ExcelField(title="汇报说明", align=2, sort=11)
	public String getXrmDescp() {
		return xrmDescp;
	}

	public void setXrmDescp(String xrmDescp) {
		this.xrmDescp = xrmDescp;
	}
	
	@Length(min=0, max=2000, message="附件长度必须介于 0 和 2000 之间")
	@ExcelField(title="附件", align=2, sort=12)
	public String getXrmFiles() {
		return xrmFiles;
	}

	public void setXrmFiles(String xrmFiles) {
		this.xrmFiles = xrmFiles;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	@ExcelField(title="流程实例ID", align=2, sort=13)
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="活动状态长度必须介于 0 和 64 之间")
	@ExcelField(title="活动状态", align=2, sort=14)
	public String getXrmStatus() {
		return xrmStatus;
	}

	public void setXrmStatus(String xrmStatus) {
		this.xrmStatus = xrmStatus;
	}
	
	@Length(min=0, max=1000, message="院系管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="院系管理员审核意见", align=2, sort=15)
	public String getXrmCollegeComment() {
		return xrmCollegeComment;
	}

	public void setXrmCollegeComment(String xrmCollegeComment) {
		this.xrmCollegeComment = xrmCollegeComment;
	}
	
	@Length(min=0, max=1000, message="系统管理员审核意见长度必须介于 0 和 1000 之间")
	@ExcelField(title="系统管理员审核意见", align=2, sort=16)
	public String getXrmManageComment() {
		return xrmManageComment;
	}

	public void setXrmManageComment(String xrmManageComment) {
		this.xrmManageComment = xrmManageComment;
	}
	
	@Length(min=0, max=1000, message="待审院系管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审院系管理员", align=2, sort=17)
	public String getXrmCollegeStandby() {
		return xrmCollegeStandby;
	}

	public void setXrmCollegeStandby(String xrmCollegeStandby) {
		this.xrmCollegeStandby = xrmCollegeStandby;
	}
	
	@Length(min=0, max=1000, message="待审系统管理员长度必须介于 0 和 1000 之间")
	@ExcelField(title="待审系统管理员", align=2, sort=18)
	public String getXrmManageStandby() {
		return xrmManageStandby;
	}

	public void setXrmManageStandby(String xrmManageStandby) {
		this.xrmManageStandby = xrmManageStandby;
	}
	
}
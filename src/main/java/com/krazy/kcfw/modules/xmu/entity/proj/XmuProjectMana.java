/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.xmu.entity.proj;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 项目Entity
 * @author Krazy
 * @version 2017-01-29
 */
public class XmuProjectMana extends DataEntity<XmuProjectMana> {
	
	private static final long serialVersionUID = 1L;
	private XmuProject xpmProjId;		// 项目ID 父类
	private String xpmOfficeId;		// 项目学院ID
	private String xpmOfficeName;		// 项目学院名称
	private String xpmUserId;		// 学院管理员ID
	private String xpmUserName;		// 学院管理员名称
	
	public XmuProjectMana() {
		super();
	}

	public XmuProjectMana(String id){
		super(id);
	}

	public XmuProjectMana(XmuProject xpmProjId){
		this.xpmProjId = xpmProjId;
	}

	@Length(min=1, max=200, message="项目ID长度必须介于 1 和 200 之间")
	public XmuProject getXpmProjId() {
		return xpmProjId;
	}

	public void setXpmProjId(XmuProject xpmProjId) {
		this.xpmProjId = xpmProjId;
	}
	
	@Length(min=1, max=64, message="项目学院ID长度必须介于 1 和 64 之间")
	//@ExcelField(title="项目学院ID", fieldType=String.class, value="", align=2, sort=7)
	public String getXpmOfficeId() {
		return xpmOfficeId;
	}

	public void setXpmOfficeId(String xpmOfficeId) {
		this.xpmOfficeId = xpmOfficeId;
	}
	
	@Length(min=1, max=64, message="项目学院名称长度必须介于 1 和 64 之间")
	@ExcelField(title="项目学院名称", align=2, sort=8)
	public String getXpmOfficeName() {
		return xpmOfficeName;
	}

	public void setXpmOfficeName(String xpmOfficeName) {
		this.xpmOfficeName = xpmOfficeName;
	}
	
	@Length(min=1, max=64, message="学院管理员ID长度必须介于 1 和 64 之间")
	//@ExcelField(title="学院管理员ID", fieldType=String.class, value="", align=2, sort=9)
	public String getXpmUserId() {
		return xpmUserId;
	}

	public void setXpmUserId(String xpmUserId) {
		this.xpmUserId = xpmUserId;
	}
	
	@Length(min=1, max=64, message="学院管理员名称长度必须介于 1 和 64 之间")
	@ExcelField(title="学院管理员名称", align=2, sort=10)
	public String getXpmUserName() {
		return xpmUserName;
	}

	public void setXpmUserName(String xpmUserName) {
		this.xpmUserName = xpmUserName;
	}
	
}
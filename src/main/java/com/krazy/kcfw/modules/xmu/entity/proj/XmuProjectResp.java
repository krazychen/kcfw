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
public class XmuProjectResp extends DataEntity<XmuProjectResp> {
	
	private static final long serialVersionUID = 1L;
	private XmuProject xprProjId;		// 项目ID 父类
	private String xprOfficeId;		// 项目学院ID
	private String xprOfficeName;		// 项目学院名称
	private String xprUserId;		// 学院负责人ID
	private String xprUserName;		// 学院负责人名称
	
	public XmuProjectResp() {
		super();
	}

	public XmuProjectResp(String id){
		super(id);
	}

	public XmuProjectResp(XmuProject xprProjId){
		this.xprProjId = xprProjId;
	}

	@Length(min=1, max=200, message="项目ID长度必须介于 1 和 200 之间")
	public XmuProject getXprProjId() {
		return xprProjId;
	}

	public void setXprProjId(XmuProject xprProjId) {
		this.xprProjId = xprProjId;
	}
	
	@Length(min=1, max=64, message="项目学院ID长度必须介于 1 和 64 之间")
	@ExcelField(title="项目学院ID", fieldType=String.class, value="", align=2, sort=7)
	public String getXprOfficeId() {
		return xprOfficeId;
	}

	public void setXprOfficeId(String xprOfficeId) {
		this.xprOfficeId = xprOfficeId;
	}
	
	@Length(min=1, max=64, message="项目学院名称长度必须介于 1 和 64 之间")
	@ExcelField(title="项目学院名称", align=2, sort=8)
	public String getXprOfficeName() {
		return xprOfficeName;
	}

	public void setXprOfficeName(String xprOfficeName) {
		this.xprOfficeName = xprOfficeName;
	}
	
	@Length(min=1, max=64, message="学院负责人ID长度必须介于 1 和 64 之间")
	@ExcelField(title="学院负责人ID", fieldType=String.class, value="", align=2, sort=9)
	public String getXprUserId() {
		return xprUserId;
	}

	public void setXprUserId(String xprUserId) {
		this.xprUserId = xprUserId;
	}
	
	@Length(min=1, max=64, message="学院负责人名称长度必须介于 1 和 64 之间")
	@ExcelField(title="学院负责人名称", align=2, sort=10)
	public String getXprUserName() {
		return xprUserName;
	}

	public void setXprUserName(String xprUserName) {
		this.xprUserName = xprUserName;
	}
	
}
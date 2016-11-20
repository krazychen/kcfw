/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.patent;

import org.hibernate.validator.constraints.Length;
import java.util.List;
import com.google.common.collect.Lists;

import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 发明专利（本科）Entity
 * @author Krazy
 * @version 2016-11-20
 */
public class SchPatentUnder extends DataEntity<SchPatentUnder> {
	
	private static final long serialVersionUID = 1L;
	private String spuId;		// spu_id
	private String spuName;		// 专利名称
	private String spuTypeCode;		// 专利类型代码
	private String spuTypeName;		// 专利类型名称
	private String spuApplySchoolName;		// 专利申请人
	private String spuApplyUserId;		// 联络人
	private String spuApplyUserOfficeId;		// 所属院系
	private String spuApplyPhone;		// 联系电话
	private String schAdvisTeacherId;		// 指导老师
	private String schAdvisTeacherOfficeId;		// 指导老师所属院系
	private String schProxyId;		// 专利代理机构
	private String schRemark;		// 专利摘要
	private List<SchPatentUnderInventor> schPatentUnderInventorList = Lists.newArrayList();		// 子表列表
	
	public SchPatentUnder() {
		super();
	}

	public SchPatentUnder(String id){
		super(id);
	}

	@Length(min=1, max=11, message="spu_id长度必须介于 1 和 11 之间")
	public String getSpuId() {
		return spuId;
	}

	public void setSpuId(String spuId) {
		this.spuId = spuId;
	}
	
	@Length(min=1, max=200, message="专利名称长度必须介于 1 和 200 之间")
	public String getSpuName() {
		return spuName;
	}

	public void setSpuName(String spuName) {
		this.spuName = spuName;
	}
	
	@Length(min=1, max=45, message="专利类型代码长度必须介于 1 和 45 之间")
	public String getSpuTypeCode() {
		return spuTypeCode;
	}

	public void setSpuTypeCode(String spuTypeCode) {
		this.spuTypeCode = spuTypeCode;
	}
	
	@Length(min=1, max=45, message="专利类型名称长度必须介于 1 和 45 之间")
	public String getSpuTypeName() {
		return spuTypeName;
	}

	public void setSpuTypeName(String spuTypeName) {
		this.spuTypeName = spuTypeName;
	}
	
	@Length(min=1, max=100, message="专利申请人长度必须介于 1 和 100 之间")
	public String getSpuApplySchoolName() {
		return spuApplySchoolName;
	}

	public void setSpuApplySchoolName(String spuApplySchoolName) {
		this.spuApplySchoolName = spuApplySchoolName;
	}
	
	@Length(min=1, max=64, message="联络人长度必须介于 1 和 64 之间")
	public String getSpuApplyUserId() {
		return spuApplyUserId;
	}

	public void setSpuApplyUserId(String spuApplyUserId) {
		this.spuApplyUserId = spuApplyUserId;
	}
	
	@Length(min=1, max=64, message="所属院系长度必须介于 1 和 64 之间")
	public String getSpuApplyUserOfficeId() {
		return spuApplyUserOfficeId;
	}

	public void setSpuApplyUserOfficeId(String spuApplyUserOfficeId) {
		this.spuApplyUserOfficeId = spuApplyUserOfficeId;
	}
	
	@Length(min=1, max=45, message="联系电话长度必须介于 1 和 45 之间")
	public String getSpuApplyPhone() {
		return spuApplyPhone;
	}

	public void setSpuApplyPhone(String spuApplyPhone) {
		this.spuApplyPhone = spuApplyPhone;
	}
	
	@Length(min=1, max=64, message="指导老师长度必须介于 1 和 64 之间")
	public String getSchAdvisTeacherId() {
		return schAdvisTeacherId;
	}

	public void setSchAdvisTeacherId(String schAdvisTeacherId) {
		this.schAdvisTeacherId = schAdvisTeacherId;
	}
	
	@Length(min=1, max=64, message="指导老师所属院系长度必须介于 1 和 64 之间")
	public String getSchAdvisTeacherOfficeId() {
		return schAdvisTeacherOfficeId;
	}

	public void setSchAdvisTeacherOfficeId(String schAdvisTeacherOfficeId) {
		this.schAdvisTeacherOfficeId = schAdvisTeacherOfficeId;
	}
	
	@Length(min=1, max=45, message="专利代理机构长度必须介于 1 和 45 之间")
	public String getSchProxyId() {
		return schProxyId;
	}

	public void setSchProxyId(String schProxyId) {
		this.schProxyId = schProxyId;
	}
	
	@Length(min=1, max=2000, message="专利摘要长度必须介于 1 和 2000 之间")
	public String getSchRemark() {
		return schRemark;
	}

	public void setSchRemark(String schRemark) {
		this.schRemark = schRemark;
	}
	
	public List<SchPatentUnderInventor> getSchPatentUnderInventorList() {
		return schPatentUnderInventorList;
	}

	public void setSchPatentUnderInventorList(List<SchPatentUnderInventor> schPatentUnderInventorList) {
		this.schPatentUnderInventorList = schPatentUnderInventorList;
	}
}
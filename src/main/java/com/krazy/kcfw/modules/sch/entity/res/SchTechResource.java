/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.res;

import org.hibernate.validator.constraints.Length;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 科研资源Entity
 * @author Krazy
 * @version 2016-12-06
 */
public class SchTechResource extends DataEntity<SchTechResource> {
	
	private static final long serialVersionUID = 1L;
	@ExcelField(title="资产分类代码",type=2)
	private String strTypeCode;		// 资产分类代码
	private String strTypeName;		// 资产分类名称
	@ExcelField(title="资产名称",type=2)
	private String strName;		// 资产名称
	@ExcelField(title="资产编号",type=2)
	private String strCode;		// 资产编号
	@ExcelField(title="计量单位",type=2)
	private String strUnit;		// 计量单位
	@ExcelField(title="数量/面积",type=2)
	private String strPices;		// 数量/面积
	@ExcelField(title="品牌/规格型号",type=2)
	private String strBrand;		// 品牌/规格型号
	@ExcelField(title="单价/均价",type=2)
	private String strPrice;		// 单价/均价
	private String strCosts;		// 费用
	@ExcelField(title="取得日期",type=2)
	private Date strCreateDate;		// 取得日期
	private String strOfficeId;		// 所属部门
	@ExcelField(title="使用部门",type=2)
	private String strOfficeName;		// 所属部门名称
	private String strUserId;		// 负责人
	@ExcelField(title="使用人",type=2)
	private String strUserName;		// 负责人名称
	private String strPhone;		// 联系电话
	
	private SchTechResourceApply[] schTechResourceApplys;
	
	
	
	/**
	 * @return the schTechResourceApplys
	 */
	public SchTechResourceApply[] getSchTechResourceApplys() {
		return schTechResourceApplys;
	}

	/**
	 * @param schTechResourceApplys the schTechResourceApplys to set
	 */
	public void setSchTechResourceApplys(
			SchTechResourceApply[] schTechResourceApplys) {
		this.schTechResourceApplys = schTechResourceApplys;
	}

	public SchTechResource() {
		super();
	}

	public SchTechResource(String id){
		super(id);
	}


	/**
	 * @return the strTypeName
	 */
	public String getStrTypeName() {
		return strTypeName;
	}

	/**
	 * @param strTypeName the strTypeName to set
	 */
	public void setStrTypeName(String strTypeName) {
		this.strTypeName = strTypeName;
	}

	/**
	 * @return the strOfficeName
	 */
	public String getStrOfficeName() {
		return strOfficeName;
	}

	/**
	 * @param strOfficeName the strOfficeName to set
	 */
	public void setStrOfficeName(String strOfficeName) {
		this.strOfficeName = strOfficeName;
	}

	/**
	 * @return the strUserName
	 */
	public String getStrUserName() {
		return strUserName;
	}

	/**
	 * @param strUserName the strUserName to set
	 */
	public void setStrUserName(String strUserName) {
		this.strUserName = strUserName;
	}

	@Length(min=1, max=64, message="资产分类代码长度必须介于 1 和 64 之间")
	public String getStrTypeCode() {
		return strTypeCode;
	}

	public void setStrTypeCode(String strTypeCode) {
		this.strTypeCode = strTypeCode;
	}
	
	@Length(min=1, max=200, message="资产名称长度必须介于 1 和 200 之间")
	public String getStrName() {
		return strName;
	}

	public void setStrName(String strName) {
		this.strName = strName;
	}
	
	@Length(min=1, max=64, message="资产编号长度必须介于 1 和 64 之间")
	public String getStrCode() {
		return strCode;
	}

	public void setStrCode(String strCode) {
		this.strCode = strCode;
	}
	
	@Length(min=1, max=64, message="计量单位长度必须介于 1 和 64 之间")
	public String getStrUnit() {
		return strUnit;
	}

	public void setStrUnit(String strUnit) {
		this.strUnit = strUnit;
	}
	
	@Length(min=1, max=64, message="数量/面积长度必须介于 1 和 64 之间")
	public String getStrPices() {
		return strPices;
	}

	public void setStrPices(String strPices) {
		this.strPices = strPices;
	}
	
	@Length(min=1, max=64, message="品牌/规格型号长度必须介于 1 和 64 之间")
	public String getStrBrand() {
		return strBrand;
	}

	public void setStrBrand(String strBrand) {
		this.strBrand = strBrand;
	}
	
	@Length(min=1, max=64, message="单价/均价长度必须介于 1 和 64 之间")
	public String getStrPrice() {
		return strPrice;
	}

	public void setStrPrice(String strPrice) {
		this.strPrice = strPrice;
	}
	
	@Length(min=0, max=64, message="费用长度必须介于 0 和 64 之间")
	public String getStrCosts() {
		return strCosts;
	}

	public void setStrCosts(String strCosts) {
		this.strCosts = strCosts;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="取得日期不能为空")
	public Date getStrCreateDate() {
		return strCreateDate;
	}

	public void setStrCreateDate(Date strCreateDate) {
		this.strCreateDate = strCreateDate;
	}
	
	@Length(min=1, max=64, message="所属部门长度必须介于 1 和 64 之间")
	public String getStrOfficeId() {
		return strOfficeId;
	}

	public void setStrOfficeId(String strOfficeId) {
		this.strOfficeId = strOfficeId;
	}
	
	@Length(min=1, max=64, message="负责人长度必须介于 1 和 64 之间")
	public String getStrUserId() {
		return strUserId;
	}

	public void setStrUserId(String strUserId) {
		this.strUserId = strUserId;
	}
	
	@Length(min=0, max=64, message="联系电话长度必须介于 0 和 64 之间")
	public String getStrPhone() {
		return strPhone;
	}

	public void setStrPhone(String strPhone) {
		this.strPhone = strPhone;
	}
	
}
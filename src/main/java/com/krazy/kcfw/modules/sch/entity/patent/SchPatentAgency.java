/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.patent;

import org.hibernate.validator.constraints.Length;

import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 专利机构信息Entity
 * @author Krazy
 * @version 2016-11-21
 */
public class SchPatentAgency extends DataEntity<SchPatentAgency> {
	
	private static final long serialVersionUID = 1L;
	private String spaCode;		// 机构代码
	private String spaName;		// 机构名称
	private String spaContacts;		// 联系人
	private String spaPhone;		// 联系方式
	private String spaAddress;		// 联系地址
	private String password; 
	
	public SchPatentAgency() {
		super();
	}

	public SchPatentAgency(String id){
		super(id);
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Length(min=1, max=45, message="机构代码长度必须介于 1 和 45 之间")
	public String getSpaCode() {
		return spaCode;
	}

	public void setSpaCode(String spaCode) {
		this.spaCode = spaCode;
	}
	
	@Length(min=1, max=100, message="机构名称长度必须介于 1 和 100 之间")
	public String getSpaName() {
		return spaName;
	}

	public void setSpaName(String spaName) {
		this.spaName = spaName;
	}
	
	@Length(min=1, max=45, message="联系人长度必须介于 1 和 45 之间")
	public String getSpaContacts() {
		return spaContacts;
	}

	public void setSpaContacts(String spaContacts) {
		this.spaContacts = spaContacts;
	}
	
	@Length(min=1, max=45, message="联系方式长度必须介于 1 和 45 之间")
	public String getSpaPhone() {
		return spaPhone;
	}

	public void setSpaPhone(String spaPhone) {
		this.spaPhone = spaPhone;
	}
	
	@Length(min=1, max=45, message="联系地址长度必须介于 1 和 45 之间")
	public String getSpaAddress() {
		return spaAddress;
	}

	public void setSpaAddress(String spaAddress) {
		this.spaAddress = spaAddress;
	}
	
}
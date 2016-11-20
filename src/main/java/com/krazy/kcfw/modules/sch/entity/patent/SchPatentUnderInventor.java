/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.patent;

import org.hibernate.validator.constraints.Length;


import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 发明专利（本科）Entity
 * @author Krazy
 * @version 2016-11-20
 */
public class SchPatentUnderInventor extends DataEntity<SchPatentUnderInventor> {
	
	private static final long serialVersionUID = 1L;
	private String spiId;		// spi_id
	private SchPatentUnder spiPatentId;		// 专利ID 父类
	private String spiTypeCode;		// 发明人类型
	private String spiUserId;		// 发明人姓名id
	private String spiUserName;		// 发明人姓名
	private String spiOfficeId;		// 发明人单位代码
	private String spiOfficeName;		// 发明人单位
	private String spiContributionPer;		// 贡献度(%)
	private String spiRemark;		// 备注
	
	public SchPatentUnderInventor() {
		super();
	}

	public SchPatentUnderInventor(String id){
		super(id);
	}

	public SchPatentUnderInventor(SchPatentUnder spiPatentId){
		this.spiPatentId = spiPatentId;
	}

	@Length(min=1, max=11, message="spi_id长度必须介于 1 和 11 之间")
	public String getSpiId() {
		return spiId;
	}

	public void setSpiId(String spiId) {
		this.spiId = spiId;
	}
	
	@Length(min=1, max=11, message="专利ID长度必须介于 1 和 11 之间")
	public SchPatentUnder getSpiPatentId() {
		return spiPatentId;
	}

	public void setSpiPatentId(SchPatentUnder spiPatentId) {
		this.spiPatentId = spiPatentId;
	}
	
	@Length(min=1, max=45, message="发明人类型长度必须介于 1 和 45 之间")
	public String getSpiTypeCode() {
		return spiTypeCode;
	}

	public void setSpiTypeCode(String spiTypeCode) {
		this.spiTypeCode = spiTypeCode;
	}
	
	@Length(min=1, max=64, message="发明人姓名id长度必须介于 1 和 64 之间")
	public String getSpiUserId() {
		return spiUserId;
	}

	public void setSpiUserId(String spiUserId) {
		this.spiUserId = spiUserId;
	}
	
	@Length(min=1, max=45, message="发明人姓名长度必须介于 1 和 45 之间")
	public String getSpiUserName() {
		return spiUserName;
	}

	public void setSpiUserName(String spiUserName) {
		this.spiUserName = spiUserName;
	}
	
	@Length(min=1, max=64, message="发明人单位代码长度必须介于 1 和 64 之间")
	public String getSpiOfficeId() {
		return spiOfficeId;
	}

	public void setSpiOfficeId(String spiOfficeId) {
		this.spiOfficeId = spiOfficeId;
	}
	
	@Length(min=1, max=45, message="发明人单位长度必须介于 1 和 45 之间")
	public String getSpiOfficeName() {
		return spiOfficeName;
	}

	public void setSpiOfficeName(String spiOfficeName) {
		this.spiOfficeName = spiOfficeName;
	}
	
	@Length(min=1, max=11, message="贡献度(%)长度必须介于 1 和 11 之间")
	public String getSpiContributionPer() {
		return spiContributionPer;
	}

	public void setSpiContributionPer(String spiContributionPer) {
		this.spiContributionPer = spiContributionPer;
	}
	
	@Length(min=0, max=2000, message="备注长度必须介于 0 和 2000 之间")
	public String getSpiRemark() {
		return spiRemark;
	}

	public void setSpiRemark(String spiRemark) {
		this.spiRemark = spiRemark;
	}
	
}
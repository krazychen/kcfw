/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.entity.res;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

import com.krazy.kcfw.common.persistence.ActEntity;
import com.krazy.kcfw.common.persistence.DataEntity;

/**
 * 科研资源申请Entity
 * @author Krazy
 * @version 2016-12-14
 */
public class SchTechResourceApply extends ActEntity<SchTechResourceApply> {
	
	private static final long serialVersionUID = 1L;
	private String scaSchId;		// 科研资源信息ID
	private String scaSchName;		// 科研资源信息
	private String scaApplyUserId;		// 申请人ID
	private String scaApplyUserName;		// 申请人ID
	private String scaApplyTimeRange;		// 申请时间段
	private String scaApplyDate;		// 申请日期
	private String scaApplyComment;		// 申请审核意见
	private String procInsId;		// 流程实例ID
	private String scaApplyDates;	
	private String scaApplyStatus;	//申请状态
	private String monthStart;
	private String monthEnd;
	private String filterStatus;
	
	public SchTechResourceApply() {
		super();
	}

	public SchTechResourceApply(String id){
		super(id);
	}

	/**
	 * @return the scaSchName
	 */
	public String getScaSchName() {
		return scaSchName;
	}

	/**
	 * @param scaSchName the scaSchName to set
	 */
	public void setScaSchName(String scaSchName) {
		this.scaSchName = scaSchName;
	}

	/**
	 * @return the filterStatus
	 */
	public String getFilterStatus() {
		return filterStatus;
	}

	/**
	 * @param filterStatus the filterStatus to set
	 */
	public void setFilterStatus(String filterStatus) {
		this.filterStatus = filterStatus;
	}

	/**
	 * @return the scaApplyUserName
	 */
	public String getScaApplyUserName() {
		return scaApplyUserName;
	}

	/**
	 * @param scaApplyUserName the scaApplyUserName to set
	 */
	public void setScaApplyUserName(String scaApplyUserName) {
		this.scaApplyUserName = scaApplyUserName;
	}

	/**
	 * @return the monthStart
	 */
	public String getMonthStart() {
		return monthStart;
	}

	/**
	 * @param monthStart the monthStart to set
	 */
	public void setMonthStart(String monthStart) {
		this.monthStart = monthStart;
	}

	/**
	 * @return the monthEnd
	 */
	public String getMonthEnd() {
		return monthEnd;
	}

	/**
	 * @param monthEnd the monthEnd to set
	 */
	public void setMonthEnd(String monthEnd) {
		this.monthEnd = monthEnd;
	}

	/**
	 * @return the scaApplyStatus
	 */
	public String getScaApplyStatus() {
		return scaApplyStatus;
	}

	/**
	 * @param scaApplyStatus the scaApplyStatus to set
	 */
	public void setScaApplyStatus(String scaApplyStatus) {
		this.scaApplyStatus = scaApplyStatus;
	}

	/**
	 * @return the scaApplyDates
	 */
	public String getScaApplyDates() {
		return scaApplyDates;
	}

	/**
	 * @param scaApplyDates the scaApplyDates to set
	 */
	public void setScaApplyDates(String scaApplyDates) {
		this.scaApplyDates = scaApplyDates;
	}

	@Length(min=1, max=64, message="科研资源信息ID长度必须介于 1 和 64 之间")
	public String getScaSchId() {
		return scaSchId;
	}

	public void setScaSchId(String scaSchId) {
		this.scaSchId = scaSchId;
	}
	
	@Length(min=1, max=64, message="申请人ID长度必须介于 1 和 64 之间")
	public String getScaApplyUserId() {
		return scaApplyUserId;
	}

	public void setScaApplyUserId(String scaApplyUserId) {
		this.scaApplyUserId = scaApplyUserId;
	}
	
	@Length(min=1, max=64, message="申请时间段长度必须介于 1 和 64 之间")
	public String getScaApplyTimeRange() {
		return scaApplyTimeRange;
	}

	public void setScaApplyTimeRange(String scaApplyTimeRange) {
		this.scaApplyTimeRange = scaApplyTimeRange;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请日期不能为空")
	public String getScaApplyDate() {
		return scaApplyDate;
	}

	public void setScaApplyDate(String scaApplyDate) {
		this.scaApplyDate = scaApplyDate;
	}
	
	@Length(min=0, max=2000, message="申请审核意见长度必须介于 0 和 2000 之间")
	public String getScaApplyComment() {
		return scaApplyComment;
	}

	public void setScaApplyComment(String scaApplyComment) {
		this.scaApplyComment = scaApplyComment;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
}
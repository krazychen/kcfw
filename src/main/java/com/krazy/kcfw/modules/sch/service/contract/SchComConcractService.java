/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.sch.service.contract;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.sch.entity.contract.SchComConcract;
import com.krazy.kcfw.modules.sch.dao.contract.SchComConcractDao;

/**
 * 普通合同Service
 * @author Krazy
 * @version 2016-11-27
 */
@Service
@Transactional(readOnly = true)
public class SchComConcractService extends CrudService<SchComConcractDao, SchComConcract> {

	public SchComConcract get(String id) {
		return super.get(id);
	}
	
	public List<SchComConcract> findList(SchComConcract schComConcract) {
		return super.findList(schComConcract);
	}
	
	public Page<SchComConcract> findPage(Page<SchComConcract> page, SchComConcract schComConcract) {
		return super.findPage(page, schComConcract);
	}
	
	@Transactional(readOnly = false)
	public void save(SchComConcract schComConcract) {
		//获取当前年月日
		SimpleDateFormat df = new SimpleDateFormat("yyMMdd");//设置日期格式
		SchComConcract schSCCNO=new SchComConcract();
		schSCCNO.setSccNo(df.format(new Date()));// new Date()为获取当前系统时间
		SchComConcract schComConcractCurr=dao.getSCCNO(schSCCNO);
		if(schComConcractCurr!=null){
			String ss=schComConcractCurr.getSccNo().substring(4);
			Integer sccNo=Integer.parseInt(ss)+1;
			schComConcract.setSccNo("XMUT"+sccNo.toString());
		}else{
			schComConcract.setSccNo("XMUT"+df.format(new Date())+"001");
		}
		schComConcract.setSccStatus("1");
		super.save(schComConcract);
	}
	
	@Transactional(readOnly = false)
	public void delete(SchComConcract schComConcract) {
		super.delete(schComConcract);
	}
	
}
/**
 * Copyright &copy; 2015-2020 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.iim.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krazy.kcfw.common.persistence.Page;
import com.krazy.kcfw.common.service.CrudService;
import com.krazy.kcfw.modules.iim.dao.ChatHistoryDao;
import com.krazy.kcfw.modules.iim.entity.ChatHistory;

/**
 * 聊天记录Service
 * @author Krazy
 * @version 2015-12-29
 */
@Service
@Transactional(readOnly = true)
public class ChatHistoryService extends CrudService<ChatHistoryDao, ChatHistory> {

	public ChatHistory get(String id) {
		return super.get(id);
	}
	
	public List<ChatHistory> findList(ChatHistory chatHistory) {
		return super.findList(chatHistory);
	}
	
	
	public Page<ChatHistory> findPage(Page<ChatHistory> page, ChatHistory entity) {
		entity.setPage(page);
		page.setList(dao.findLogList(entity));
		return page;
	}
	
	public Page<ChatHistory> findGroupPage(Page<ChatHistory> page, ChatHistory entity) {
		entity.setPage(page);
		page.setList(dao.findGroupLogList(entity));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ChatHistory chatHistory) {
		super.save(chatHistory);
	}
	
	@Transactional(readOnly = false)
	public void delete(ChatHistory chatHistory) {
		super.delete(chatHistory);
	}
	
	public int findUnReadCount(ChatHistory chatHistory){
		return dao.findUnReadCount(chatHistory);
	}
	
}
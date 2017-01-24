/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/krazy/kcfw">kcfw</a> All rights reserved.
 */
package com.krazy.kcfw.modules.test.entity.note;


import com.krazy.kcfw.common.persistence.DataEntity;
import com.krazy.kcfw.common.utils.excel.annotation.ExcelField;

/**
 * 富文本测试Entity
 * @author liugf
 * @version 2016-10-04
 */
public class TestNote extends DataEntity<TestNote> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 标题
	private String contents;		// 内容
	
	public TestNote() {
		super();
	}

	public TestNote(String id){
		super(id);
	}

	@ExcelField(title="标题", align=2, sort=7)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@ExcelField(title="内容", align=2, sort=8)
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
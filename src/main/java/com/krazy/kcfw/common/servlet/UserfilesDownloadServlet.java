package com.krazy.kcfw.common.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.util.UriUtils;

import com.krazy.kcfw.common.config.Global;
import com.krazy.kcfw.common.utils.FileUtils;

/**
 * 查看CK上传的图片
 * @author krazy
 * @version 2014-06-25
 */
public class UserfilesDownloadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	public void fileOutputStreamNew(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		String filepath = req.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_URL);
		if(index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath);
        //判断文件是否存在
        if(!file.exists()) {
            return;
        }
        FileUtils.downFile(file, req, resp);
//		ServletOutputStream out;  
//		try {
////			resp.setHeader("Content-Type", "application/octet-stream;chaset=utf-8");
////			resp.setContentType("text/csv;charset=UTF-8");
//			resp.setContentType("multipart/form-data");  
////			resp.setContentType("multipart/form-data;charset=UTF-8");  
////			resp.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
////			resp.setHeader("Content-Disposition", "attachment;fileName=" + new String(file.getName().getBytes("GBK"), "iso-8859-1"));
//			resp.setHeader("Content-Disposition", "attachment;fileName=" + file.getName());
//			FileCopyUtils.copy(new FileInputStream(file), resp.getOutputStream());
//			return;
//		} catch (FileNotFoundException e) {
//			req.setAttribute("exception", new FileNotFoundException("请求的文件不存在"));
//			req.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(req, resp);
//		}
	}

	public void fileOutputStream(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		String filepath = req.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_URL);
		if(index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath);
		ServletOutputStream out;  
		try {
//			resp.setHeader("Content-Type", "application/octet-stream;chaset=utf-8");
//			resp.setContentType("text/csv;charset=UTF-8");
			resp.setContentType("multipart/form-data");  
//			resp.setContentType("multipart/form-data;charset=UTF-8");  
//			resp.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
//			resp.setHeader("Content-Disposition", "attachment;fileName=" + new String(file.getName().getBytes("GBK"), "iso-8859-1"));
			resp.setHeader("Content-Disposition", "attachment;fileName=" + file.getName());
			FileCopyUtils.copy(new FileInputStream(file), resp.getOutputStream());
			return;
		} catch (FileNotFoundException e) {
			req.setAttribute("exception", new FileNotFoundException("请求的文件不存在"));
			req.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStreamNew(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStreamNew(req, resp);
	}
}

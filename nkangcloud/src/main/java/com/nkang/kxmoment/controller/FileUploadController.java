package com.nkang.kxmoment.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nkang.kxmoment.util.FileOperateUtil;

@Controller
@RequestMapping("/fileUpload")
public class FileUploadController {
	private static Logger log=Logger.getLogger(FileUploadController.class);
	@RequestMapping(value = "/uploadPlatforRelated", produces = "text/html;charset=UTF-8")
	public ModelAndView readXlsOfPlatforRelated(HttpServletRequest request,HttpServletResponse response){
		
		FileOperateUtil.readMetricsMapping();
		
		ModelAndView mv=new ModelAndView("MDMDataVisualization");
	
		DiskFileItemFactory factory = new DiskFileItemFactory();
	    factory.setSizeThreshold(1024 * 1024);
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    upload.setFileSizeMax(1024 * 1024 * 2);
	    upload.setHeaderEncoding("utf-8");
	    upload.setSizeMax(1024 * 1024 * 4);

		 List<FileItem> fileList = null;
		 	String message = "文件导入失败，请重新导入..";
		 	Map map =new HashMap<String,List>();
		    try {
		        fileList = upload.parseRequest(new ServletRequestContext(request));
		        if(fileList != null){
		            for(FileItem item:fileList){
		            	//String filename="";
		            	   if(!item.isFormField() && item.getSize() > 0){
		                	InputStream is = item.getInputStream();
		                	map=FileOperateUtil.OperateOnPlatforRelated(is);
		                	 message=message+map.get("APJ").toString()+"<br>";
		                	 message=message+map.get("USA").toString()+"<br>";
		                	 message=message+map.get("MEXICO").toString()+"<br>";
		                	 message=message+map.get("EMEA").toString()+"<br>";
		                    if(is!=null){
		                    	is.close();
		                    }
		                }
		            }
		        }
		           
		    } catch (Exception e) {
		        e.printStackTrace();
		        log.info("fileurl-===--"+e.getMessage());
		        message = "fail--"+e.toString()+"  fileList-size="+ fileList.size() +" message="+ message+" item.isFormField() ="+fileList.get(0).isFormField()+" && item.getSize()="+ fileList.get(0).getSize();
		    
		    }
		    mv.addObject("map", map);
			return mv;

	}
	/*
	public void ReadAGM() throws IOException{
		
	    String url  = FileUploadController.class.getClassLoader().getResource("AGM_Maping.xls").getPath();
	    String message="";
	    InputStream is = null;
		try {
			is = new FileInputStream(url);
			
			 message=FileOperateUtil.readAGM(is);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		//	return message;  
	}*/
	
	@RequestMapping(value = "/uploadReport", produces = "text/html;charset=UTF-8")
	public ModelAndView readXlsOfuploadReport(HttpServletRequest request,HttpServletResponse response){
		
		FileOperateUtil.readMetricsMapping();
		
		ModelAndView mv=new ModelAndView("MDMDataVisualizationB");
		DiskFileItemFactory factory = new DiskFileItemFactory();
	    factory.setSizeThreshold(1024 * 1024);
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    upload.setFileSizeMax(1024 * 1024 * 2);
	    upload.setHeaderEncoding("utf-8");
	    upload.setSizeMax(1024 * 1024 * 4);

		 List<FileItem> fileList = null;
		 Map map =new HashMap<String,Integer>();
		 	String message = "文件导入失败，请重新导入..";
		    try {
		        fileList = upload.parseRequest(new ServletRequestContext(request));
		        if(fileList != null){
		            for(FileItem item:fileList){
		            	//String filename="";
		            	   if(!item.isFormField() && item.getSize() > 0){
		                	InputStream is = item.getInputStream();
		                	map=FileOperateUtil.OperateOnReport(is);
		                    if(is!=null){
		                    	is.close();
		                    }
		                }
		            }
		        }
		           
		    } catch (Exception e) {
		        e.printStackTrace();
		        log.info("fileurl-===--"+e.getMessage());
		        message = "fail--"+e.toString()+"  fileList-size="+ fileList.size() +" message="+ message+" item.isFormField() ="+fileList.get(0).isFormField()+" && item.getSize()="+ fileList.get(0).getSize();
		    
		    }
		    mv.addObject("map", map);
			return mv;
	}
	
	
}

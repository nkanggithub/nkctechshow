package com.nkang.kxmoment.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.nkang.kxmoment.util.FileOperateUtil;
import com.nkang.kxmoment.util.ImageUtil;
import com.nkang.kxmoment.util.MongoDBBasic;
import com.nkang.kxmoment.util.RestUtils;

@Controller
@RequestMapping("/file2Upload")
public class FileUploadController {
	private static Logger log=Logger.getLogger(FileUploadController.class);
	

	@RequestMapping(value = "/uploadImg", produces = "text/html;charset=UTF-8")
	public @ResponseBody String uploadImg(HttpServletRequest request,HttpServletResponse response) throws IOException, FileUploadException{
		DiskFileItemFactory factory = new DiskFileItemFactory();
	    factory.setSizeThreshold(1024 * 1024);
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    upload.setFileSizeMax(1024 * 1024 * 2);
	    upload.setHeaderEncoding("utf-8");
	    upload.setSizeMax(1024 * 1024 * 4);
	    int total = 0;
		 List<FileItem> fileList = null;
		 List<String> outNames=null;
		 Map<String, Integer> map =new HashMap<String,Integer>();
		 	String message = "文件导入失败，请重新导入..";
		        fileList = upload.parseRequest(new ServletRequestContext(request));
		        if(fileList != null){
		            for(FileItem item:fileList){
		            	//String filename="";
		            	   if(!item.isFormField() && item.getSize() > 0){
		            		   //	String access_token = "YRJm7nuItwIjgXFjTUVRBZjw33Z4IVywsR4tLjQG2OFyvtMR1cF5hWyG4w2YmVSgsYUXNPmemrBBob169vmjtwxYUVScYpfTJ2q6xJOtxiDZRp4auQepY0SjEv7p7vu8GEYfAHAWUO";     
		            		 String access_token =MongoDBBasic.getValidAccessKey();
		        	       System.out.println("access_token------:"+access_token);   
		        	        //上传图片素材      
		        	        String path="https://api.weixin.qq.com/cgi-bin/media/upload?access_token="+access_token+"&type=image";  
		        	        String result=RestUtils.connectHttpsByPost(path, null, item);    
		        	        JSONObject resultJSON=JSONObject.parseObject(result);
		        	        if(resultJSON!=null){  
		        	            if(resultJSON.get("media_id")!=null){  
		        	            	log.debug("上传图文消息内的图片成功");  
		        	                return resultJSON.get("media_id").toString();  
		        	            }else{  
		        	            	log.error("上传图文消息内的图片失败");  
		        	            	 return "failed";
		        	            }  
		        	        }  
		        	          

		        		   //request.getSession().setAttribute("outNames", outNames);
		        		   // request.getSession().setAttribute("total", total);
		        		   
		                   
		                }
		            }
		        }
				return message;
		            
	          
	       
	}
	@RequestMapping(value = "/uploadNews", produces = "text/html;charset=UTF-8")
	public @ResponseBody String uploadNews(HttpServletRequest request,HttpServletResponse response) {
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String mediaID=request.getParameter("mediaID");
		String url=request.getParameter("url");
		String articleID=RestUtils.uploadNews(mediaID,title,content,url);   
		articleID=articleID.substring(7, articleID.length());   
        JSONObject resultJSON=JSONObject.parseObject(articleID);
        if(resultJSON!=null){  
            if(resultJSON.get("media_id")!=null){  
            	articleID= resultJSON.get("media_id").toString();  
            }
        }
//        MongoDBBasic.InsertArtcleID(articleID);
		return articleID;
        
	}
	@RequestMapping(value = "/sendMass", produces = "text/html;charset=UTF-8")
	public @ResponseBody String sendMass(HttpServletRequest request,HttpServletResponse response) throws JSONException {
		List<String> userList = MongoDBBasic.getAllOpenID();
//		List<String> userList=ArrayList<String>();
//		userList.add("oqPI_xDdGid-HlbeVKZjpoO5zoKw");
//		userList.add("oqPI_xACjXB7pVPGi5KH9Nzqonj4");
		int realReceiver=0;
		String articleID=request.getParameter("articleID");
		System.out.println("articleID:----"+articleID);
		String status=RestUtils.sendMass(userList, articleID);
		System.out.println("status:----"+status);
         if(RestUtils.getValueFromJson(status,"errcode").equals("0")){
      	   realReceiver=userList.size();
         }
		return realReceiver+"";
	}
}

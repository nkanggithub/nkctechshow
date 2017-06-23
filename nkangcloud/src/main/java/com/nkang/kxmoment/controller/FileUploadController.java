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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.nkang.kxmoment.baseobject.PlatforRelated;
import com.nkang.kxmoment.util.FileOperateUtil;
import com.nkang.kxmoment.util.MongoDBBasic;
import com.nkang.kxmoment.util.RestUtils;

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
		 	List<String> OutOfMapping = null;
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
		                	 OutOfMapping = (List<String>) map.get("OutOfMapping");
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
		    mv.addObject("OutOfMapping", OutOfMapping);
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
	    int total = 0;
		 List<FileItem> fileList = null;
		 List<String> outNames=null;
		 Map<String, Integer> map =new HashMap<String,Integer>();
		 	String message = "文件导入失败，请重新导入..";
		    try {
		        fileList = upload.parseRequest(new ServletRequestContext(request));
		        if(fileList != null){
		            for(FileItem item:fileList){
		            	//String filename="";
		            	   if(!item.isFormField() && item.getSize() > 0){
		            		PlatforRelated  platforRelated=new PlatforRelated();
		                	InputStream is = item.getInputStream();
		                	//map=FileOperateUtil.OperateOnReport(is);
		                	platforRelated=FileOperateUtil.OperateOnReport(is);
		                	map.put("APJ", platforRelated.getClosed_APJ());
		         			map.put("USA", platforRelated.getClosed_USA());
		         			map.put("MEXICO", platforRelated.getClosed_MEXICO());
		         			map.put("EMEA", platforRelated.getClosed_EMEA());
		         			map.put("OTHER", platforRelated.getClosed_OTHER());
		         			outNames=platforRelated.getOutNames();
		         			total=platforRelated.getIMMetricstotal();
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
		   //request.getSession().setAttribute("outNames", outNames);
		   // request.getSession().setAttribute("total", total);
		    mv.addObject("map", map);
		    mv.addObject("total", total);
		    mv.addObject("outNames", outNames);
			return mv;
	}
	
	@RequestMapping(value = "/getIMMetrics", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView getIMMetrics(HttpServletRequest request, @RequestParam(value="ClientStockCode", required=true) String clientStockCode) {
		ModelAndView mv=new ModelAndView("MDMDataVisualizationB");
		Map<String, Integer> map = new HashMap<String,Integer>();
		PlatforRelated pr = MongoDBBasic.getPlatforRelated(clientStockCode);
		if(pr==null){
			return mv;
		}
		
		map.put("APJ", pr.getClosed_APJ());
		map.put("USA", pr.getClosed_USA());
		map.put("MEXICO", pr.getClosed_MEXICO());
		map.put("EMEA", pr.getClosed_EMEA());
		map.put("OTHER", pr.getClosed_OTHER());
		mv.addObject("map", map);
		//return map.get("APJ")+" "+map.get("USA")+" "+map.get("MEXICO")+" "+map.get("EMEA")+" "+map.get("OTHER");
		return mv;
	}
	
	@RequestMapping(value = "/getRunMaintainMetrics", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView getRunMaintainMetrics(HttpServletRequest request, @RequestParam(value="ClientStockCode", required=true) String clientStockCode) {
		ModelAndView mv=new ModelAndView("MDMDataVisualization");
		Map<String, List> map =new HashMap<String,List>();
		PlatforRelated platforRelated = MongoDBBasic.getPlatforRelated(clientStockCode);
		if(platforRelated==null){
			return mv;
		}
		
		List<Integer> APJlt = new ArrayList<Integer>();
		APJlt.add(platforRelated.getDone_APJ());
		APJlt.add(platforRelated.getInProgress_APJ());
		APJlt.add(platforRelated.getInPlanning_APJ());
		
		List<Integer> USAlt = new ArrayList<Integer>();
		USAlt.add(platforRelated.getDone_USA());
		USAlt.add(platforRelated.getInProgress_USA());
		USAlt.add(platforRelated.getInPlanning_USA());
		
		List<Integer> MEXICOlt = new ArrayList<Integer>();
		MEXICOlt.add(platforRelated.getDone_MEXICO());
		MEXICOlt.add(platforRelated.getInProgress_MEXICO());
		MEXICOlt.add(platforRelated.getInPlanning_MEXICO());
		
		List<Integer> EMEAlt = new ArrayList<Integer>();
		EMEAlt.add(platforRelated.getDone_EMEA());
		EMEAlt.add(platforRelated.getInProgress_EMEA());
		EMEAlt.add(platforRelated.getInPlanning_EMEA());
		
		map.put("APJ", APJlt);
		map.put("USA", USAlt);
		map.put("MEXICO", MEXICOlt);
		map.put("EMEA", EMEAlt);
		mv.addObject("map", map);
		return mv;
	}
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
		String articleID=RestUtils.uploadNews(mediaID,title,content);   
		articleID=articleID.substring(7, articleID.length());   
        JSONObject resultJSON=JSONObject.parseObject(articleID);
        if(resultJSON!=null){  
            if(resultJSON.get("media_id")!=null){  
            	articleID= resultJSON.get("media_id").toString();  
            }
        }
		return MongoDBBasic.InsertArtcleID(articleID)+"";
        
	}
	@RequestMapping(value = "/sendMass", produces = "text/html;charset=UTF-8")
	public @ResponseBody String sendMass(HttpServletRequest request,HttpServletResponse response) {
		List<String> userList = null;
		String artcleID=request.getParameter("artcleID");
		return RestUtils.sendMass(userList,artcleID);
	}
}

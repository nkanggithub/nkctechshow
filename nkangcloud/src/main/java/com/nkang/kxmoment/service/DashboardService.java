package com.nkang.kxmoment.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.bson.types.ObjectId;
import org.json.JSONArray;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.nkang.kxmoment.baseobject.ClientMeta;
import com.nkang.kxmoment.baseobject.DashboardStatus;
import com.nkang.kxmoment.baseobject.WeChatMDLUser;
import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.MongoDBBasic;
import com.nkang.kxmoment.util.RestUtils;
import com.nkang.kxmoment.util.SmsUtils.RestTest;
/**
 * Dashboard Service 
 * @author xue-ke.du
 *
 */
public class DashboardService {
	private static Logger logger = Logger.getLogger(DashboardService.class);
	private static DB db = MongoDBBasic.getMongoDB();
	private static DBCollection statusCollection = db.getCollection("DashboardStatus");
	private static Date lastsendtimestamp = new Date();
	/**
	 * Save or Update(if exists status of type)
	 * @param statusVo
	 * @return
	 */
	public static String saveStatus(DashboardStatus statusVo) {
		String status = "fail";
		try {
			if(statusVo==null||statusVo.equals("")){
				return status;
			}
			String statusStr = (String)statusVo.getStatus();
			statusStr = statusStr.replaceAll("\\\"", "\"");
			JSONArray obj = new JSONArray(statusStr);
			statusVo.setStatus(obj);
			DBObject dbObj = BasicDBObject.parse(statusVo.toString());
			DBObject query = new BasicDBObject();
			query.put("type", statusVo.getType());
			// insert or update
			statusCollection.update(query, dbObj, true, false);
			status = "success";
			int isDown=0;
			if(statusStr.toUpperCase().indexOf("DOWN")!=-1){
				isDown++;
			}
			//String codeAll="{\"map\":{\"status\":";	
			String code404="{\"map\":{\"status\":\"404\"";
			//String code200="{\"map\":{\"status\":\"200\"";
			//String code405="{\"map\":{\"status\":\"405\",\"description\":\"Cleanse\"";		
			List<DashboardStatus> StrList = findAllStatusList();
			String str = StrList.toString();
			
			//int tatol=subCounter(str, codeAll);
			int status404=subCounter(str, code404);
			//int status200=subCounter(str, code200);
			//int status405=subCounter(str, code405);
			//int ret=tatol-status200-status405;
			//logger.info("tatol:"+tatol+",status200:"+status200+",status405"+status405);
			Date dt = new Date();
			if(status404>0 || isDown>0){
				if( dt.getTime() - lastsendtimestamp.getTime() > 1000*60*4){
					
					ClientMeta cm=MongoDBBasic.QueryClientMeta();
					String respContent = "服务器异常短讯已发送至：";
					logger.info("SmsSwitch:"+cm.getSmsSwitch());
					if(cm.getSmsSwitch()!=null&&"true".equals(cm.getSmsSwitch())){
						
						String templateId="62068";
						String para="";
						String to="";
						String userName="";
						ArrayList<HashMap> telList = MongoDBBasic.QuerySmsUser();

						//logger.info("telListSize:"+telList.size());
						/*List<String> telList = new ArrayList<String>();
						telList.add("15123944895");//Ning
						telList.add("13668046589");//Shok
						telList.add("15310898146");//Port
						telList.add("13661744205");//Garden*/
						
						for(HashMap T : telList){
							to = T.get("phone").toString();
							userName = T.get("realName").toString();
							respContent+=(userName+" ");
							if(to!=null && !"".equals(to)){
								RestTest.testTemplateSMS(true, Constants.ucpass_accountSid,Constants.ucpass_token,Constants.ucpass_appId, templateId,to,para);
							}
						}
						
						for(HashMap T : telList){
							List<String> toUser=new ArrayList<String>();
							toUser.add(T.get("OpenID").toString());
							RestUtils.sendTextMessageToUser(respContent,toUser);
						}
						//微信
						lastsendtimestamp = dt;
						List<WeChatMDLUser> allUser = MongoDBBasic.getWeChatUserFromMongoDB("");
						String content="产品运维团队，请立即查看该服务器异常并及时沟通。";
						String title=" 生产环境服务器出现异常，请立即采取措施！！！";
						for(int i=0;i<allUser.size();i++){
							String uri="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx19c8fd43a7b6525d&redirect_uri=http%3A%2F%2Fshenan.duapp.com%2Fmdm%2FDashboardStatus.jsp&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect&UID=";
								RestUtils.sendQuotationToUser(allUser.get(i),content,"https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EBM2m&oid=00D90000000pkXM","【"+allUser.get(i).getNickname()+"】"+title,uri);
							// RestUtils.sendQuotationToUser(allUser.get(i),content,"https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EBM2m&oid=00D90000000pkXM","【"+allUser.get(i).getNickname()+"】"+title,"http://shenan.duapp.com/mdm/DashboardStatus.jsp?UID=");
						}

					}
				//	logger.info("sendTextMessageToUser");
				}
			
				/*
				List<WeChatMDLUser> allUser = MongoDBBasic.getWeChatUserFromMongoDB("");
				String content="产品运维团队，请立即查看该服务器异常并及时沟通。";
				String title=" 生产环境服务器出现异常，请立即采取措施！！！";
				for(int i=0;i<allUser.size();i++){
					 RestUtils.sendQuotationToUser(allUser.get(i),content,"https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EBM2m&oid=00D90000000pkXM","【"+allUser.get(i).getNickname()+"】"+title,"http://shenan.duapp.com/mdm/DashboardStatus.jsp?UID=");
				}
				
				String templateId="62080";
				String para="";
				String to="";
				List<String> telList = new ArrayList<String>();
				telList.add("15123944895");//Ning
				telList.add("13668046589");//Shok
				telList.add("15310898146");//Port
				telList.add("13661744205");//Garden
				for(String T : telList){
					to = T;
					if(to!=null && !"".equals(to)){
						RestTest.testTemplateSMS(true, Constants.ucpass_accountSid,Constants.ucpass_token,Constants.ucpass_appId, templateId,to,para);
					}
				}
				//sending sms
				//RestTest.testTemplateSMS(true, Constants.ucpass_accountSid,Constants.ucpass_token,Constants.ucpass_appId, templateId,to,para);
			*/}
			
			
			
		} catch (Exception e) {
			//logger.error("Save Status fail.", e);
			status = "fail";
		}
		return status;
	}
	
	//util
	
	public static int subCounter(String str1, String str2) {
		 
        int counter = 0;
        for (int i = 0; i <= str1.length() - str2.length(); i++) {
            if (str1.substring(i, i + str2.length()).equalsIgnoreCase(str2)) {
                counter++;
            }
        }
         return counter;
    }

	
	/**
	 * Get KM list
	 * @return
	 */
	public static List<DashboardStatus> findAllStatusList() {
		List<DashboardStatus> list = null;
		try {
			DBCursor cursor = statusCollection.find();
			if(cursor.length() > 0){
				list = new ArrayList<DashboardStatus>(cursor.size());
			}
			Iterator<DBObject> iterator = cursor.iterator();
			while (iterator.hasNext()) {
				DBObject dbObject = (DBObject) iterator.next();
				DashboardStatus statusVo =  DashboardStatus.gson.fromJson(dbObject.toString(), DashboardStatus.class);
				list.add(statusVo);
			}
		} catch (Exception e) {
			logger.error("Find KM List fail.", e);
			list = null;
		}
		return list;
	}

	/**
	 * get status detail
	 * @param type
	 * @return
	 */
	public static DashboardStatus getStatus(String type) {
		DashboardStatus statusVo = null;
		try {
			DBObject query = new BasicDBObject();
			query.put("type", new ObjectId(type));
			DBCursor cursor = statusCollection.find(query);
			Iterator<DBObject> iterator = cursor.iterator();
			if (iterator.hasNext()) {
				DBObject dbObject = (DBObject) iterator.next();
				statusVo = DashboardStatus.gson.fromJson(dbObject.toString(), DashboardStatus.class);
			}
		} catch (Exception e) {
			logger.error("Get status Detail fail.", e);
			statusVo = null;
		}
		return statusVo;
	}
}

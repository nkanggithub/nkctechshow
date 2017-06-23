package com.nkang.kxmoment.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Timer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.dom4j.Element;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.DBObject;
import com.nkang.kxmoment.baseobject.ArticleMessage;
import com.nkang.kxmoment.baseobject.ClientMeta;
import com.nkang.kxmoment.baseobject.CongratulateHistory;
import com.nkang.kxmoment.baseobject.ExtendedOpportunity;
import com.nkang.kxmoment.baseobject.FaceObj;
import com.nkang.kxmoment.baseobject.GeoLocation;
import com.nkang.kxmoment.baseobject.WeChatUser;
import com.nkang.kxmoment.response.Article;
import com.nkang.kxmoment.response.NewsMessage;
import com.nkang.kxmoment.response.TextMessage;
import com.nkang.kxmoment.util.CommenJsonUtil;
import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.CronJob;
import com.nkang.kxmoment.util.FaceRecognition;
import com.nkang.kxmoment.util.MessageUtil;
import com.nkang.kxmoment.util.MongoDBBasic;
import com.nkang.kxmoment.util.RestUtils;

public class CoreService
{
	private static Logger log = Logger.getLogger(CoreService.class);
	private static Timer timer= new Timer();
	public static String processRequest(HttpServletRequest request)
	{
		
		String respXml = null;
		String respContent = "unknown request type.";
		String AccessKey = MongoDBBasic.getValidAccessKey();
		ClientMeta cm=MongoDBBasic.QueryClientMeta(Constants.clientCode);
		try {
			Element requestObject 	= 	MessageUtil.parseXml(request);
			String fromUserName 	= 	requestObject.element("FromUserName").getText();
			String toUserName 		= 	requestObject.element("ToUserName").getText();
			String msgType 			= 	requestObject.element("MsgType").getText();
			

			
			TextMessage textMessage = new TextMessage();
			textMessage.setToUserName(fromUserName);
			textMessage.setFromUserName(toUserName);
			textMessage.setCreateTime(new Date().getTime());
			textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);

			TextMessage textMessage1 = new TextMessage();
			String fromUserName1 = "oqPI_xHLkY6wSAJEmjnQPPazePE8";
			textMessage1.setToUserName(fromUserName1);
			textMessage1.setFromUserName(toUserName);
			textMessage1.setCreateTime(new Date().getTime());
			textMessage1.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			
			NewsMessage newsMessage = new NewsMessage();
			newsMessage.setToUserName(fromUserName);
			newsMessage.setFromUserName(toUserName);
			newsMessage.setCreateTime(new Date().getTime());
			newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);

			List<Article> articleList = new ArrayList<Article>();

			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {
				String textContent = requestObject.element("Content").getText().trim();

                String status="";
				int realReceiver=0;
				if ("cm".equals(textContent)) {
					respContent = RestUtils.createMenu(AccessKey);
					textMessage.setContent(respContent);
					respXml = MessageUtil.textMessageToXml(textMessage);
					
				}
				else if (textContent.contains("trigger:")) {
					String content= textContent.split(":")[1];
                    List<String> toUser=MongoDBBasic.getAllOpenID();
                    status=RestUtils.sendTextMessageToUser(content, toUser);
                   if(RestUtils.getValueFromJson(status,"errcode").equals("0")){
                	   realReceiver=toUser.size();
                   }
                   textMessage.setContent(realReceiver + " recevied");
	                respXml = MessageUtil.textMessageToXml(textMessage);
	                
				} else if (textContent.contains("articleUpload")) {
	                textMessage.setContent("http://shenan.duapp.com/mdm/uploadArticle.jsp");
	                respXml = MessageUtil.textMessageToXml(textMessage);
				}
                   else if (textContent.contains("articleSend")) {
                	   String articleID=MongoDBBasic.getArticleID();
                	   System.out.println("articleID-----------"+articleID);
                       List<String> articletoUser=MongoDBBasic.getAllOpenID();
//                	   List<String> articletoUser=new ArrayList<String>();
//                	   articletoUser.add("oqPI_xDdGid-HlbeVKZjpoO5zoKw");
//                	   articletoUser.add("oqPI_xEjbhsIuu4DcfxED6IqDQ5o");
                       status=RestUtils.sendMass(articletoUser, articleID);
                      if(RestUtils.getValueFromJson(status,"errcode").equals("0")){
                   	   realReceiver=articletoUser.size();
                      }
                   
	                textMessage.setContent(realReceiver + " recevied");
	                respXml = MessageUtil.textMessageToXml(textMessage);
				}
				else {
					List<String> allUser = MongoDBBasic.getAllOpenIDByIsActivewithIsRegistered();
	                for(int i=0;i<allUser.size();i++){
	                     if(fromUserName.equals(allUser.get(i))){
	                         allUser.remove(i);
	                     }
	                }
	                    
                 for(int i=0;i<allUser.size();i++){
                    status=RestUtils.sendTextMessageToUserOnlyByCustomInterface(textContent,allUser.get(i),fromUserName);
                   if(RestUtils.getValueFromJson(status,"errcode").equals("0")){
                	   realReceiver++;
                   }
                 }
	                textMessage.setContent(realReceiver + " recevied");
	                respXml = MessageUtil.textMessageToXml(textMessage);
				}
			}

			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) {
				respContent = "LINK";
				textMessage.setContent(respContent);
				respXml = MessageUtil.textMessageToXml(textMessage);
			}
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) {
				respContent = "VOICE";
				List<DBObject> results = MongoDBBasic.getDistinctSubjectArea("industrySegmentNames");
				respContent = respContent + results.size() + "\n";

				textMessage.setContent(respContent);
				respXml = MessageUtil.textMessageToXml(textMessage);
			}
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VIDEO)) {
				respContent = "VIDEO";
				textMessage.setContent(respContent);
				respXml = MessageUtil.textMessageToXml(textMessage);
			}
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
				String eventType = requestObject.element("Event").getText();
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
					WeChatUser wcu = RestUtils.getWeChatUserInfo(AccessKey, fromUserName);
					//DBUtils.createUser(wcu);
					Boolean ret =  false;
					if(wcu.getOpenid() != "" || wcu.getOpenid() != null){
						ret = MongoDBBasic.createUser(wcu);
					}
					articleList.clear();
					Article article = new Article();
					article.setTitle("移动应用");
					article.setDescription("移动应用");
					article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9m1P&oid=00D90000000pkXM");
					article.setUrl("http://"+Constants.baehost+"/mdm/DQNavigate.jsp?UID=" + fromUserName);
					articleList.add(article);

					Article article4 = new Article();
					article4.setTitle("Data Visualization");
					article4.setDescription("Master Data Visualization");
					article4.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009urNv&oid=00D90000000pkXM");
					article4.setUrl("http://"+Constants.baehost+"/DQMenu?UID=" + fromUserName);
					articleList.add(article4);
					newsMessage.setArticleCount(articleList.size());
					newsMessage.setArticles(articleList);
					respXml = MessageUtil.newsMessageToXml(newsMessage);
					if(!ret){
						respContent = "User Initialization Failed：\n";
						textMessage.setContent(respContent);
						respXml = MessageUtil.textMessageToXml(textMessage);
					}
				} else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
					// Inactive the User - To-Be-Done
					MongoDBBasic.removeUser(fromUserName);

				} else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
					String eventKey = requestObject.element("EventKey").getText();
					if(eventKey.equals("MDLAKE")){ // Data Lake
						articleList.clear();
						Article article = new Article();
						article.setTitle("我的主数据");
						article.setDescription("我的主数据");
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DlU1k&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/DQNavigate.jsp?UID=" + fromUserName);
						articleList.add(article);
						Article article4 = new Article();
						article4.setTitle("主数据可视化");
						article4.setDescription("Master Data Visualization");
						article4.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DlU1k&oid=00D90000000pkXM");
						article4.setUrl("http://"+Constants.baehost+"/DQMenu?UID=" + fromUserName);
						articleList.add(article4);
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					}
					else if(eventKey.equals("MYAPPS")){
						articleList.clear();
						Article article = new Article();
						
						article.setTitle(cm.getClientName()+"|移动应用");
						article.setDescription("移动应用");
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9mpP&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/DQNavigate.jsp?UID=" + fromUserName);
						articleList.add(article);
						Article article2 = new Article();
						article2.setTitle("微应用");
						article2.setDescription("My Personal Applications");
						article2.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9j7K&oid=00D90000000pkXM");
						article2.setUrl("http://"+Constants.baehost+"/mdm/profile.jsp?UID=" + fromUserName);
						articleList.add(article2);
						String hardcodeUID = "oqPI_xLq1YEJOczHi4DS2-1U0zqc";
						if(hardcodeUID.equalsIgnoreCase(fromUserName)||MongoDBBasic.checkUserAuth(fromUserName, "isAdmin")){
							Article article3 = new Article();
							article3.setTitle("微管理");
							article3.setDescription("Administration");
							article3.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9j7e&oid=00D90000000pkXM");
							article3.setUrl("http://"+Constants.baehost+"/admin/index.jsp?UID=" + fromUserName);
							articleList.add(article3);
						}
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					}
					else if(eventKey.equals("MYRECOG")){
						articleList.clear();
						Article article = new Article();
						article.setTitle("My Lasted Recognitions");
						article.setDescription("My Lasted Recognition");
						article.setPicUrl("http://"+Constants.baehost+"/MetroStyleFiles/RecognitionImage.jpg");
						article.setUrl("http://"+Constants.baehost+"/mdm/DQNavigate.jsp?UID=" + fromUserName);
						articleList.add(article);
						
						// add article here
						List<CongratulateHistory> myrecoghistList = MongoDBBasic.getRecognitionInfoByOpenID(fromUserName, "");
						int myRecog = myrecoghistList.size();
						if(myRecog > 6){
							myRecog = 6;
						}
						Article myarticle;
						CongratulateHistory congratulateHistory;
						String icoURLPartnerFirst = "https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DkaRc&oid=00D90000000pkXM";
						String icoURLBaisForAction = "https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DkaS6&oid=00D90000000pkXM";
						String icoURLInnovator = "https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000DkaSa&oid=00D90000000pkXM";
						String icoURL = "http://"+Constants.baehost+"/MetroStyleFiles/RecognitionImage.jpg";
						for(int i = myRecog; i >= 1; i--){
							myarticle = new Article();
							congratulateHistory = new CongratulateHistory();
							congratulateHistory = myrecoghistList.get(i-1);
							String type = congratulateHistory.getType();
							String comments  = congratulateHistory.getComments();
							if(StringUtils.isEmpty(comments)){
								comments = "You must done something amazaing";
							}
							else if(comments.length() >= 30){
								comments =  comments.trim();
								comments = comments.substring(0, 30) + "...";
							}
							myarticle.setTitle(congratulateHistory.getComments()  +"\n" + congratulateHistory.getCongratulateDate() + " | " + congratulateHistory.getFrom() + "\n" + type);
							myarticle.setDescription("My Recognition");
							if(type.equalsIgnoreCase("Bais For Action")){
								icoURL = icoURLBaisForAction;
							}
							else if(type.equalsIgnoreCase("Innovators at Heart")){
									icoURL = icoURLInnovator;
							}
							else{ 
								icoURL = icoURLPartnerFirst;
							}
							myarticle.setPicUrl(icoURL);
							myarticle.setUrl("http://"+Constants.baehost+"/mdm/RecognitionCenter.jsp?uid=" + fromUserName + "&num="+i);
							articleList.add(myarticle);
						}						

						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					}
					else if (eventKey.equals("nbcolleague")) {
						GeoLocation geol = MongoDBBasic.getDBUserGeoInfo(fromUserName);
						String lat = geol.getLAT();
						String lng = geol.getLNG();
						String addr = geol.getFAddr();
						Article article = new Article();
						Random rand = new Random();
						int randNum = rand.nextInt(30);
						article.setTitle("点击扫描您附近的同事");
						article.setDescription("您当前所在位置:" + addr);
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9rIB&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/scan/scan.jsp?UID=" + fromUserName+"&num="+randNum);
						articleList.add(article);
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
						
					}else if (eventKey.equals("myPoints")) {//使劲戳我
						HashMap<String, String> user = MongoDBBasic.getWeChatUserFromOpenID(fromUserName);
						String respContent1 = "";
						Date d = new Date();  
				        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
				        String dateNowStr = sdf.format(d);  
						if(MongoDBBasic.checkUserPoint(fromUserName)){
					        java.util.Random random=new java.util.Random();// 定义随机类
					        int randomNum=random.nextInt(5)+1;// 返回[0,10)集合中的整数，注意不包括10
					        
							int pointSum=MongoDBBasic.updateUserPoint(fromUserName, randomNum);
							respContent1 = "* * * * * * * * * * * * * * * * *\n"
								+"* 欢迎您："+user.get("NickName")+"\n"
								+"* 今日积分："+randomNum+"\n"
								+"* 当前积分："+pointSum+"\n"
								+"*\n"
								+"*             =^_^=\n"
								+"* 好感动，您今天又来了\n"
								+"* 今日积分已入账，记得\n"
								+"* 每天都来看我哦！\n";
								
						}else{
							int pointSum=MongoDBBasic.updateUserPoint(fromUserName, 0);
							respContent1 = "* * * * * * * * * * * * * * * * *\n"
									+"* 欢迎您："+user.get("NickName")+"\n"
									+"* 当前积分："+pointSum+"\n"
									+"* 时间："+dateNowStr+"\n"
									+"*\n"
									+"*             =^_^=\n"
									+"* 好感动，您今天又来了\n"
									+"* 但每天只有一次获取积\n"
									+"* 分的机会哦！！\n";
						}
						respContent1=respContent1
								+"* * * * * * * * * * * * * * * * *\n"
								+"* 【温馨提示： 希望您能\n"
								+"*  天天这里点一点逛一\n"
								+"*  逛，这样才能收到我们\n"
								+"*  高价值的消息推送，以\n"
								+"*  便于我们为您提供更\n"
								+"*  好的服务】\n"
								+"* * * * * * * * * * * * * * * * *";
						textMessage.setContent(respContent1);
						respXml = MessageUtil.textMessageToXml(textMessage);

					}else if (eventKey.equals("mysubscription")) {//我的订阅
						Article article = new Article();
						Random rand = new Random();
						int randNum = rand.nextInt(30);
						article.setTitle(cm.getClientName()+"| 点击查看我的订阅");
						article.setDescription("在此您可以随心订阅您感兴趣的专业话题和自身的职业发展方向");
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9mnn&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/RoleOfAreaMap.jsp?UID=" + fromUserName+"&num="+randNum);
						articleList.add(article);
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
						
					}
					else if (eventKey.equals("opsmetric")) {//我的订阅
						
						articleList.clear();
						Article article = new Article();
						article.setTitle(cm.getClientName()+"|查看产品运维报表");
						article.setDescription("您可查看实时更新的产品运维报表");
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000E9j6l&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/DV_Mobile.jsp?UID=" + fromUserName);
						articleList.add(article);
						
						Article article1 = new Article();
						article1.setTitle("IM统计情况");
						article1.setDescription("IM统计情况");
						article1.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EBLNZ&oid=00D90000000pkXM");
						article1.setUrl("http://"+Constants.baehost+"/mdm/DV_Mobile.jsp?UID=" + fromUserName);
						articleList.add(article1);
						
						Article article2 = new Article();
						article2.setTitle("生产环境智能监控");
						article2.setDescription("生产环境智能监控");
						article2.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EBLMl&oid=00D90000000pkXM");
						//article2.setUrl("http://shenan.duapp.com/mdm/DashboardStatus.jsp?UID=" + fromUserName);
						article2.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx19c8fd43a7b6525d&redirect_uri=http%3A%2F%2Fshenan.duapp.com%2Fmdm%2FDashboardStatus.jsp&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect");
						articleList.add(article2);
						
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
						
						
						
					}
					else if (eventKey.equals("nbcust")) {// Customer
						String CurType = "customer";
						GeoLocation geol = MongoDBBasic.getDBUserGeoInfo(fromUserName);
						String lat = geol.getLAT();
						String lng = geol.getLNG();
						String addr = geol.getFAddr();
						List<ExtendedOpportunity> NearByOpptsExt =  new ArrayList<ExtendedOpportunity>();
						List<String> cityInfo = new ArrayList<String>();
						cityInfo = RestUtils.getUserCityInfoWithLatLng(lat,lng);
						NearByOpptsExt = MongoDBBasic.getNearByOpptFromMongoDB(cityInfo.get(0), cityInfo.get(1), cityInfo.get(2), CurType, lat, lng);
						Article article = new Article();
						article.setTitle(NearByOpptsExt.size() + " Customers NearBy DXC ");
						article.setDescription(NearByOpptsExt.size() + " Customers " +  "Found Near By You \n" + addr);
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2eJ&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/mdm/MoreCustomer.jsp?UID=" + fromUserName);
						articleList.add(article);
						int opptCount = 7;
						if(NearByOpptsExt.size() < opptCount ){
							opptCount = NearByOpptsExt.size();
						}
						for(int i = 0; i < opptCount ;  i++){
							Article articlevar = new Article();
							articlevar.setTitle(NearByOpptsExt.get(i).getOpptName() + "\n" + NearByOpptsExt.get(i).getSegmentArea() + "\n" + NearByOpptsExt.get(i).getDistance() + " KM");
							articlevar.setDescription("NearBy Opportunity");
							articlevar.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2gP&oid=00D90000000pkXM");
							articlevar.setUrl("http://"+Constants.baehost+"/mdm/MoreCustomer.jsp?UID=" + fromUserName);
							articleList.add(articlevar);
						}
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
						
					} else if (eventKey.equals("nbcompe")) {// Competitor
						String CurType = "competitor";
						GeoLocation geol = MongoDBBasic.getDBUserGeoInfo(fromUserName);
						String lat = geol.getLAT();
						String lng = geol.getLNG();
						String addr = geol.getFAddr();

						List<ExtendedOpportunity> NearByOpptsExt =  new ArrayList<ExtendedOpportunity>();
						List<String> cityInfo = new ArrayList<String>();
						cityInfo = RestUtils.getUserCityInfoWithLatLng(lat,lng);
						NearByOpptsExt = MongoDBBasic.getNearByOpptFromMongoDB(cityInfo.get(0), cityInfo.get(1), cityInfo.get(2), CurType, lat, lng);

						Article article = new Article();
						article.setTitle(NearByOpptsExt.size() + " Competitors NearBy DXC");
						article.setDescription(NearByOpptsExt.size() +  " Competitor " +  "Found Near By You \n" + addr);
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2eJ&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/index.jsp");
						articleList.add(article);
						int opptCount = 7;
						if(NearByOpptsExt.size() < opptCount ){
							opptCount = NearByOpptsExt.size();
						}
						for(int i = 0; i < opptCount ;  i++){
							Article articlevar = new Article();
							articlevar.setTitle(NearByOpptsExt.get(i).getOpptName() + "\n" + NearByOpptsExt.get(i).getSegmentArea() + "\n" + NearByOpptsExt.get(i).getDistance() + " KM");
							articlevar.setDescription("NearBy Opportunity");
							articlevar.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2gP&oid=00D90000000pkXM");
							articlevar.setUrl("http://"+Constants.baehost+"/index.jsp");
							articleList.add(articlevar);
						}
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					} 
					else if (eventKey.equals("nbpartner")) {// Partner
						String CurType = "partner";
						GeoLocation geol = MongoDBBasic.getDBUserGeoInfo(fromUserName);
						String lat = geol.getLAT();
						String lng = geol.getLNG();
						String addr = geol.getFAddr();

						List<ExtendedOpportunity> NearByOpptsExt =  new ArrayList<ExtendedOpportunity>();
						List<String> cityInfo = new ArrayList<String>();
						cityInfo = RestUtils.getUserCityInfoWithLatLng(lat,lng);
						NearByOpptsExt = MongoDBBasic.getNearByOpptFromMongoDB(cityInfo.get(0), cityInfo.get(1), cityInfo.get(2), CurType, lat, lng);

						Article article = new Article();
						article.setTitle(NearByOpptsExt.size() + " Partners NearBy DXC");
						article.setDescription(NearByOpptsExt.size() + " Partner " +  "Found Near By You \n" + addr);
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2eJ&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/index.jsp");
						articleList.add(article);
						int opptCount = 7;
						if(NearByOpptsExt.size() < opptCount ){
							opptCount = NearByOpptsExt.size();
						}
						for(int i = 0; i < opptCount ;  i++){
							Article articlevar = new Article();
							articlevar.setTitle(NearByOpptsExt.get(i).getOpptName() + "\n" + NearByOpptsExt.get(i).getSegmentArea() + "\n" + NearByOpptsExt.get(i).getDistance() + " KM");
							articlevar.setDescription("NearBy Opportunity");
							articlevar.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2gP&oid=00D90000000pkXM");
							articlevar.setUrl("http://"+Constants.baehost+"/index.jsp");
							articleList.add(articlevar);
						}
						
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					}
					else if (eventKey.equals("nboppt")) {// Partner
						/*String CurType = "";
						GeoLocation geol = MongoDBBasic.getDBUserGeoInfo(fromUserName);
						String lat = geol.getLAT();
						String lng = geol.getLNG();
						String addr = geol.getFAddr();
						
						List<ExtendedOpportunity> NearByOpptsExt =  new ArrayList<ExtendedOpportunity>();
						List<String> cityInfo = new ArrayList<String>();
						cityInfo = RestUtils.getUserCityInfoWithLatLng(lat,lng);
						NearByOpptsExt = MongoDBBasic.getNearByOpptFromMongoDB(cityInfo.get(0), cityInfo.get(1), cityInfo.get(2), "", lat, lng);

						Article article = new Article();
						article.setTitle(NearByOpptsExt.size() + " Opportunity NearBy DXC ");
						article.setDescription(NearByOpptsExt.size() + " Opportunity " +  "Found Near By You \n" + addr);
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2eJ&oid=00D90000000pkXM");
						article.setUrl("http://"+Constants.baehost+"/index.jsp");
						articleList.add(article);
						int opptCount = 7;
						if(NearByOpptsExt.size() < opptCount ){
							opptCount = NearByOpptsExt.size();
						}
						for(int i = 0; i < opptCount ;  i++){
							Article articlevar = new Article();
							articlevar.setTitle(NearByOpptsExt.get(i).getOpptName() + "\n" + NearByOpptsExt.get(i).getSegmentArea() + "\n" + NearByOpptsExt.get(i).getDistance() + " KM");
							articlevar.setDescription("NearBy Opportunity");
							articlevar.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=01590000009v2gP&oid=00D90000000pkXM");
							articlevar.setUrl("http://"+Constants.baehost+"/index.jsp");
							articleList.add(articlevar);
						}
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);*/
						Article article = new Article();
						article.setTitle("更多精彩尽在往期回顾 ");
						article.setDescription("更多精彩尽在往期回顾 ");
						article.setPicUrl("https://c.ap1.content.force.com/servlet/servlet.ImageServer?id=0159000000EDHHL&oid=00D90000000pkXM");
						article.setUrl("http://shenan.duapp.com/mdm/MesPushHistory.jsp");
						articleList.add(article);
						List<ArticleMessage> ams=MongoDBBasic.getArticleMessageByNum("");
						for(int i = 0; i < 3 ;  i++){
							Article articlevar = new Article();
							articlevar.setTitle(ams.get(i).getTitle()+"\n"+ams.get(i).getTime());
							articlevar.setDescription("");
							if(ams.get(i).getPicture()!=null&&ams.get(i).getPicture()!=""){
							articlevar.setPicUrl(ams.get(i).getPicture());
							}
							else{
								articlevar.setPicUrl("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490602667276&di=5ff160cb3a889645ffaf2ba17b4f2071&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F65%2F94%2F64B58PICiVp_1024.jpg");
							}
							articlevar.setUrl("http://shenan.duapp.com/mdm/NotificationCenter.jsp?num="+ams.get(i).getNum());
							articleList.add(articlevar);
						}
						newsMessage.setArticleCount(articleList.size());
						newsMessage.setArticles(articleList);
						respXml = MessageUtil.newsMessageToXml(newsMessage);
					}

				} else if (eventType.equals(MessageUtil.EVENT_TYPE_SCAN_TEXT)) {
					String eventKey = requestObject.element("EventKey").getText();
					if (eventKey.equals("C1")) {
						respContent = requestObject.element("ScanCodeInfo").element("ScanResult").getText();
						textMessage.setContent(respContent);
						respXml = MessageUtil.textMessageToXml(textMessage);
					}
				} else if (eventType.equals(MessageUtil.EVENT_TYPE_SCAN_URL)) {
					respContent = "scan url and redirect.";
					textMessage.setContent(respContent);
					respXml = MessageUtil.textMessageToXml(textMessage);
				} else if (eventType.equals(MessageUtil.EVENT_TYPE_SCAN)) {
					respContent = "scan qrcode.";
					textMessage.setContent(respContent);
					respXml = MessageUtil.textMessageToXml(textMessage);
				} else if (eventType.equals(MessageUtil.EVENT_TYPE_LOCATION)) {
					respContent = "upload location detail.";
					textMessage.setContent(respContent);
					WeChatUser wcu = RestUtils.getWeChatUserInfo(AccessKey, fromUserName);
					MongoDBBasic.updateUser(fromUserName, requestObject.element("Latitude").getText(), requestObject.element("Longitude").getText(),wcu);
				} else if (eventType.equals(MessageUtil.EVENT_TYPE_VIEW)) {
					respContent = "page redirect.";
					textMessage.setContent(respContent);
					respXml = MessageUtil.textMessageToXml(textMessage);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return respXml;
	}
	
}

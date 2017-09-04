package com.dxc.it.mdm.dashborad;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/**
 * 
 * @author DXK
 *
 */
public class ServerStatusMonitor {
	
	// 等待时间 单位：秒
	private static long intervalTime = 60;
	// dashboard 服务端Url
	private static String dashboardServerURL = "http://mdcp-monitor.houston.hp.com:8180";
	// 保存状态的Url
//	private static String saveStatusURL = "http://shenan.duapp.com/Dashboard/saveStatus";
	private static String saveStatusURL = "http://127.0.0.1:8080/ROOT/Dashboard/saveStatus";
	private static String sorlUsername = "hpit:w-mdcp-mdm-prd";
	private static String sorlPassword = "3reojowdN+";
	
	
	/**
	 * 获取数据
	 * @param url
	 * @return
	 */
	private static String getStatus(String url){
		System.out.println("getStatus URL : " + url);
		url = dashboardServerURL + url;
		String jsonstring = null;
		try {
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			jsonstring = response.toString();
		} catch (Exception e) {
			System.err.println("getStatus fail. url:"+url);
			e.printStackTrace();
		}
		System.out.println("getStatus responsed.");
		return jsonstring;
	}

	/**
	 * 发送数据
	 * @param type
	 * @param dataStr
	 */
	private static void postStatus(String type, String dataStr) {
		try {
			CloseableHttpClient httpclient = HttpClients.createDefault();
			// 实例化post方法  
	        HttpPost httpPost = new HttpPost(saveStatusURL);
	        // 非本地则用代理
	        if(!"http://127.0.0.1:8080/ROOT/Dashboard/saveStatus".equals(saveStatusURL)){
				// 设置代理
		        HttpHost proxy = new HttpHost("web-proxy.austin.hpecorp.net", 8080, "http");
		        RequestConfig config = RequestConfig.custom().setProxy(proxy).build();
		        httpPost.setConfig(config);
	        }
			// 设置参数
	        List<NameValuePair> nvps = new ArrayList <NameValuePair>();
            nvps.add(new BasicNameValuePair("type", type));
            nvps.add(new BasicNameValuePair("status", dataStr));
            //提交的参数  
            UrlEncodedFormEntity uefEntity  = new UrlEncodedFormEntity(nvps, "UTF-8");  
            //将参数给post方法  
            httpPost.setEntity(uefEntity); 
	        String content="";
            //执行post方法  
	        CloseableHttpResponse response = httpclient.execute(httpPost);  
            if(response.getStatusLine().getStatusCode()==200){  
                content = EntityUtils.toString(response.getEntity(),"utf-8");
                System.out.println("["+ type + "]postStatus : " + content); 
                // 失败后，再次请求
                if(!"Check".equals(type) && (content == null || !content.equals("success"))){
                	Thread.sleep(1000);
                	System.out.println("Re postStatus");
                	postStatus(type, dataStr);
                	return;
                }
            }else{
            	System.out.println("postStatus fail. StatusCode:" + response.getStatusLine().getStatusCode());
            }
		} catch (Exception e) {
			System.err.println("postStatus error. type:"+type);
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 */
	private static String getSolrStatus(String solrServerURL, String description){
		String content = "";
        try {
        	/*
	    	String path = SolrClientUtils.class.getResource("").toString().replace("file:", "");
	    	String certificationPath = path+"jssecacerts";
	        System.setProperty("javax.net.ssl.trustStore", certificationPath);
	        */
			CloseableHttpClient httpclient = HttpClients.createDefault();
	        HttpRequestBase request = new HttpGet(solrServerURL + "/select?q=organizationId%3A123456&wt=json&indent=true");
	        request.addHeader("username", sorlUsername);
	        request.addHeader("password", sorlPassword);
	        String url = "http://" + request.getURI().getAuthority() + "/solr";
	        
	        long beginT = System.nanoTime();
	        
	        //执行post方法  
			CloseableHttpResponse response = httpclient.execute(request);
			int status = response.getStatusLine().getStatusCode();
			/*if(response.getStatusLine().getStatusCode()==200){
                String content = EntityUtils.toString(response.getEntity(),"utf-8");
                System.out.println(content);
			}*/
			if(checkSolrUpdateTimeout(solrServerURL)){
				// 判断是否更新数据超时（1Hour）
				status = 500;
			}
			long endT = System.nanoTime();
			double responseTime = (endT - beginT) / 1000000000d;
			content = "{";
			content += "\"url\":\""+ url +"\",";
			content += "\"type\":\"TOMCAT\",";
			content += "\"status\":\""+ status +"\",";
			content += "\"description\":\""+ description +"\",";
			content += "\"responseTime\":\""+ responseTime +"\"";
			content += "}";
			System.out.println(description + " getSolrStatus: " + request.getURI().getHost()+"|"+status+"|"+responseTime);
		} catch (Exception e) {
			e.printStackTrace();
		}  
        return content;
	}
	
	/**
	 * 检查Solr更新是否超时
	 * @param solrServerURL
	 * @return true为已超时(1h)，false为未超时
	 */
	private static boolean checkSolrUpdateTimeout(String solrServerURL){
		boolean flag = false;
		try {
			CloseableHttpClient httpclient = HttpClients.createDefault();
	        HttpRequestBase request = new HttpGet(solrServerURL + "/admin/luke?wt=json&show=index&numTerms=0&_="+new Date().getTime());
	        request.addHeader("username", sorlUsername);
	        request.addHeader("password", sorlPassword);
	        CloseableHttpResponse response = httpclient.execute(request);
	        String content = EntityUtils.toString(response.getEntity(),"utf-8");
	
			// 获取更新时间
	        String regEx = "lastModified\":\"(.*?)\"";
	        Pattern pat = Pattern.compile(regEx);
	        Matcher mat = pat.matcher(content);
	        String lastModified = null;
	        if(mat.find()){
	        	lastModified = mat.group(1);
	        }
	        if(lastModified != null){
	        	// 解析UAT时间
	        	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'");
	        	df.setTimeZone(TimeZone.getTimeZone("UTC"));
	        	Date lmodifDate = df.parse(lastModified);
	        	Date now = new Date();
	        	long hourUnit = 1000*60*60; //小时单位
	        	long differ = now.getTime() - lmodifDate.getTime(); //相差时间
	        	// 超过一小时
	        	if(differ > hourUnit*1){
	        		long diffHour = differ / hourUnit;
	        		System.out.println(solrServerURL+", 已有"+ diffHour + "小时未更新");
	        		flag = true;
	        	} /*else if(differ > hourUnit/60){
	        		long diffMinute = differ / hourUnit/60;
	        		System.out.println("已有"+ diffMinute + "分钟未更新");
	        	} else if(differ > 1000){
	        		long diffSecond = differ / 1000;
	        		System.out.println("已有"+ diffSecond + "秒未更新");
	        	}*/
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 同步状态数据
	 */
	private static void doSyncStatus() {
		System.out.println("transStatus Begin >>> " + new Date());
		String jbossUrl = "/api/getJbossStatus/PRO";
		String dbUrl = "/api/getDatabaseStatus/PRO";
		String msgUrl = "/api/getMessages/PRO";
		String jobsUrl = "/api/getJobStatus/PRO";
		String stRulesEngineUrl = "/api/getStRulesEngineStatus/PRO";
		String stRulesEngineHPIUrl = "/api/getStRulesEngineStatusHPI/PRO";
		String stRulesEngineFrcstUrl = "/api/getStRulesEngineFrcstStatus/PRO";
		String stRulesEngineFrcstHPIUrl = "/api/getStRulesEngineFrcstStatusHPI/PRO";
		String solrServerURL4HPE_1 = "http://g9t2975.houston.hp.com:8080/solr/organization-account";
		String solrServerURL4HPE_2 = "http://g4t4598.houston.hp.com:8080/solr/organization-account";
		String solrServerURL4HPI_1 = "http://g9t2975.houston.hp.com:8180/solr/organization-account";
		String solrServerURL4HPI_2 = "http://g4t4598.houston.hp.com:8180/solr/organization-account";
		String solrServerURL4SOST = "http://g4t4597.houston.hp.com:8080/solr/organization-account";
		
		// Jboss
		String statusData = getStatus(jbossUrl);
		// 获取solr状态位置
		int solrStatusIdx = statusData.indexOf("{\"url\":\"http://g4t4591.houston.hp.com:8180/mdmportal\"");
		if(solrStatusIdx > -1){
			StringBuilder builder = new StringBuilder(statusData);
			String statusData4Solr = "";
			// 获取Solr数据
			statusData4Solr += getSolrStatus(solrServerURL4HPE_1, "Solr HPE") + ",";
			statusData4Solr += getSolrStatus(solrServerURL4HPE_2, "Solr HPE") + ",";
			statusData4Solr += getSolrStatus(solrServerURL4HPI_1, "Solr HPI") + ",";
			statusData4Solr += getSolrStatus(solrServerURL4HPI_2, "Solr HPI") + ",";
			statusData4Solr += getSolrStatus(solrServerURL4SOST, "Solr SOST") + ",";
			builder.insert(solrStatusIdx, statusData4Solr);
			statusData = builder.toString();
		}
		// 先调用接口，避免保存JBOSS失败
		postStatus("Check", "[{}]");
		postStatus("JBOSS", statusData);
		// DB
		statusData = getStatus(dbUrl);
		postStatus("DB", statusData);
		// MSG
		statusData = getStatus(msgUrl);
		postStatus("MSG", statusData);
		// JOB
		statusData = getStatus(jobsUrl);
		postStatus("JOB", statusData);
		// stRulesEngine
		statusData = getStatus(stRulesEngineUrl);
		postStatus("STRulesHPE", statusData);
		// stRulesEngineHPIUrl
		statusData = getStatus(stRulesEngineHPIUrl);
		postStatus("STRulesHPI", statusData);
		// stRulesEngineFrcstUrl
		statusData = getStatus(stRulesEngineFrcstUrl);
		postStatus("FrcstSTRulesHPE", statusData);
		// stRulesEngineFrcstHPIUrl
		statusData = getStatus(stRulesEngineFrcstHPIUrl);
		postStatus("FrcstSTRulesHPI", statusData);
		System.out.println("transStatus End >>> " + new Date());
	}
	
	
	public static void main(String[] args) {
		// 解析参数
		if(args != null && args.length > 0){
			System.out.println("Initial Params ...");
			try {
				if(args.length==1){
					long tmp = Long.parseLong(args[0]);
					if(tmp > 0){
						// 设置等待时间
						intervalTime = tmp;
					}
				}else{
					for (int i = 0; i < args.length; i++) {
						if(i < args.length-1){
							if("intervalTime".equals(args[i])){
								long tmp = Long.parseLong(args[i+1]);
								if(tmp > 0){
									// 设置等待时间
									intervalTime = tmp;
									System.out.println("intervalTime : "+intervalTime);
								}
							}else if("saveStatusURL".equals(args[i])){
								// 请求地址
								saveStatusURL = args[i+1];
								System.out.println("saveStatusURL : "+saveStatusURL);
							}
						}
					}
				}
			} catch (Exception e) {
				System.out.println("args issue");
				e.printStackTrace();
			}
		}
		System.out.println("\n");
		// 开始任务
		while (true) {
			// 同步状态数据
			doSyncStatus();
			try {
				System.out.println(intervalTime + "s needed waiting...");
				Thread.sleep(1000*intervalTime);
			} catch (InterruptedException e) {
				System.err.println("Sleep Error");
				e.printStackTrace();
			}
		}
	}
}

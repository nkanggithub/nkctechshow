package com.nkang.kxmoment.util;


public final class Constants {
	private Constants(){}
	public static final String WECHAT_TOKEN = "SDFCTOKENNKCNKANG";
	public static final String APP_ID = "wx022b55e5bdea4c51";
	public static final String APPSECRET = "d3d79cc28df35c18bd192761c77ddd74";

	/*	wechat config*/
	public static final String BAIDU_APPKEY = "92a801f6881743d1b222c58b7dbe2475";
	public static final String BAIDU_APPSECRET  = "6d7fb5881a9b430596cc915d22ed7241";
	public static final String GOOGLE_KEY = "AIzaSyB3bZ1N7XRiQu2M4ZB3QQMxd3VVLnzrRK4";
	public static final String proxyInfo = "web-proxy.austin.hpecorp.net";
	public static final String baehost = "nkctech.duapp.com";
	public static final String clientCode = "NKC";
	public static final String clientCodeCN = "NKC";
	public static final String wechatapihost = "api.weixin.qq.com";
	public static final String baiduapihost = "api.map.baidu.com";
	public static final String bucketName = "nkctech";
	public static final String bosDomain = "nkctech.gz.bcebos.com";
	
	/*	SMS config*/
	public static final String ucpass_accountSid = "e332d0755b9060b20ecb53a244ec7015";
	public static final String ucpass_token = "6dc9593907118f61208d1c1531337bc0";
	public static final String ucpass_appId = "d9944779258e42ad8683b2ac2c4e92da";
	
	/*	wechat payment config*/
	public static final String devOpenID = "oI3krwR_gGNsz38r1bdB1_SkcoNw";
	public static final String prodID= "1469932302";
	public static final String partnerKey= "53fead94b3acec49763585f18b7b6nkc";
	public static final String mcthID= "1469932302";
	public static final String payBody= "在线购买";
	public static final String deviceInfo= "WEB";
	public static final String notifyURL= "http://"+baehost+"/wxpay/WechatPayNotify.jsp";
	public static final String notifyPresentURL= "http://"+baehost+"/wxpay/WechatPayPresent.jsp";
	public static final String signType= "MD5";
	public static final String tradeType= "JSAPI";
	public static final String tradeTypeNative= "NATIVE";
	public static final String totalFee= "1";
	public static final String clientCNName= "重庆市神安化工建材有限公司";

	/**
	 * 
	 * MongoDB 集合名字
	 */
	public final class MONGO_CLN_NAMES{
		public static final String KM = "KMPool";
	}
}

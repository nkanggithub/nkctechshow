package com.nkang.test;


import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

import com.nkang.kxmoment.util.Constants;



import com.nkang.kxmoment.util.WeixinPay.api.PayUtils;
import com.nkang.kxmoment.util.WeixinPay.utils.HttpsRequest;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

public class testMain {

    public static void main(String[] args) throws Exception {
    	String b = PayUtils.generateMchPayNativeRequestURL("1469932302");
    	HttpsRequest req =  new HttpsRequest();
    	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", b); //POST发送到统一支付接口
    	System.out.println(xmlStr);
    	
    	if(xmlStr.contains("prepay_id")){
    		System.out.println("---OK to get prepay ID--");
    		String[] a =xmlStr.split("prepay_id");
    		
    		String aa =  a[1].substring(10);
    		String cc = aa.substring(0,aa.length()-5);
    		System.out.println(aa);
    		System.out.println("---OK to get prepay ID--" + cc);
    	}
    	
    }

}
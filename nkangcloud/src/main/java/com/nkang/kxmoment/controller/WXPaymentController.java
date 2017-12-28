package com.nkang.kxmoment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nkang.kxmoment.service.CoreService;
import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.WeixinPay.api.PayUtils;
import com.nkang.kxmoment.util.WeixinPay.utils.HttpsRequest;
import com.nkang.kxmoment.util.WeixinPay.utils.MD5;
import com.nkang.kxmoment.util.WeixinPay.utils.Signature;

@Controller
public class WXPaymentController {
	private static Logger log = Logger.getLogger(CoreService.class);
	@RequestMapping("/pay/payparm")  
    public void payparm(HttpServletRequest request, HttpServletResponse response){  
        try {  

	    	String b = PayUtils.generateMchPayNativeRequestURL(Constants.prodID);
	    	HttpsRequest req =  new HttpsRequest();
	    	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", b);
	    	log.info("---XMLString From payment request---" + xmlStr);

    		String[] a =xmlStr.split("prepay_id");
    		String aa =  a[1].substring(10);
    		String prepay_id = aa.substring(0,aa.length()-5);

    		String timeStamp = String.valueOf((System.currentTimeMillis()/1000));//1970年到现在的秒数
            String nonceStr = MD5.getNonceStr().toUpperCase(); 
            Map<String, String> payMap = new HashMap<String, String>();  

            payMap.put("appId", Constants.APP_ID);  
            payMap.put("timeStamp", timeStamp);  
            payMap.put("nonceStr", nonceStr);  
            payMap.put("signType", "MD5");  
            payMap.put("package", "prepay_id=" + prepay_id);
            
            String paySign = Signature.generateSign(payMap);  
            payMap.put("pg", "prepay_id=" + prepay_id);
            payMap.put("paySign", paySign);
              
            // 拼接并返回json  
            StringBuilder sBuilder = new StringBuilder("[{");  
            sBuilder.append("appId:'").append(Constants.APP_ID).append("',")  
                        .append("timeStamp:'").append(timeStamp).append("',")  
                        .append("nonceStr:'").append(nonceStr).append("',")  
                        .append("pg:'").append("prepay_id=" + prepay_id).append("',")  
                        .append("signType:'MD5',")  
                        .append("paySign:'").append(paySign).append("'");  
            sBuilder.append("}]");  
            log.info("---StringPaymentAfter" + sBuilder.toString());
            response.getWriter().print(sBuilder.toString());  
            response.getWriter().close();  
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
    }
}

package com.nkang.kxmoment.controller;

import java.util.HashMap;
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
import com.nkang.kxmoment.util.WeixinPay.utils.Signature;

@Controller
public class WXPaymentController {
	private static Logger log = Logger.getLogger(CoreService.class);
	@RequestMapping("/pay/payparm")  
    public void payparm(HttpServletRequest request, HttpServletResponse response){  
        try {  
/*
        	
        	String openId = Constants.devOpenID;
            String appid = Constants.APP_ID;
            String paternerKey = Constants.partnerKey; 
              
            String out_trade_no = "111"; 
            Map<String, String> paraMap = new HashMap<String, String>();  
            paraMap.put("appid", appid);  
            paraMap.put("attach", "测试");  
            paraMap.put("body", "测试购买支付");  
            paraMap.put("mch_id", "1469932302");  
            paraMap.put("nonce_str", "123");  
            paraMap.put("openid", openId);  
            paraMap.put("out_trade_no", out_trade_no);  
            //paraMap.put("spbill_create_ip", getAddrIp(request));  
            paraMap.put("total_fee", "1");  
            paraMap.put("trade_type", "JSAPI");  
            paraMap.put("notify_url", "http://nkctech.duapp.com/mdm/AddQuestions.jsp");// 此路径是微信服务器调用支付结果通知路径  
            String sign = getSign(paraMap, paternerKey);  
            paraMap.put("sign", sign);  
            // 统一下单 https://api.mch.weixin.qq.com/pay/unifiedorder  
            String url = "https://api.mch.weixin.qq.com/pay/unifiedorder";  
  */
        	log.info("---Ii am here---");
	    	String b = PayUtils.generateMchPayNativeRequestURL(Constants.prodID);
	    	log.info("---Ii am here b---" + b);
	    	HttpsRequest req =  new HttpsRequest();
	    	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", b);
	    	log.info("---Ii am here---2" + xmlStr);
/*            String xml = ArrayToXml(paraMap);  */
  
            /*String xmlStr = HttpKit.post(url, xml);  */
  
            // 预付商品id  
            String prepay_id = "111111111";  //from xmlStr parse
  
/*            if (xmlStr.indexOf("SUCCESS") != -1) {  
                Map<String, String> map = doXMLParse(xmlStr);  
                prepay_id = (String) map.get("prepay_id");  
            }  */
            
            prepay_id = "111111111";
  
            String timeStamp = "12345";  
            String nonceStr = "12345";
            Map<String, String> payMap = new HashMap<String, String>();  
            payMap.put("appId", Constants.APP_ID);  
            payMap.put("timeStamp", timeStamp);  
            payMap.put("nonceStr", nonceStr);  
            payMap.put("signType", "MD5");  
            payMap.put("package", "prepay_id=" + prepay_id);  
            String paySign = Signature.generateSign(payMap);  
              
            payMap.put("pg", prepay_id);  
            payMap.put("paySign", paySign);  
              
            // 拼接并返回json  
            StringBuilder sBuilder = new StringBuilder("[{");  
            sBuilder.append("appId:'").append(Constants.APP_ID).append("',")  
                        .append("timeStamp:'").append(timeStamp).append("',")  
                        .append("nonceStr:'").append(nonceStr).append("',")  
                        .append("pg:'").append(prepay_id).append("',")  
                        .append("signType:'MD5',")  
                        .append("paySign:'").append(paySign).append("'");  
            sBuilder.append("}]");  
            response.getWriter().print(sBuilder.toString());  
            response.getWriter().close();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }

	
}

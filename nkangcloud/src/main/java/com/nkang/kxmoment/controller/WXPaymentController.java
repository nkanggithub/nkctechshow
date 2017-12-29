package com.nkang.kxmoment.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nkang.kxmoment.service.CoreService;
import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.WeixinPay.bean.PayQrCode;
import com.nkang.kxmoment.util.WeixinPay.utils.HttpsRequest;
import com.nkang.kxmoment.util.WeixinPay.utils.Signature;

@Controller
public class WXPaymentController {
	private static Logger log = Logger.getLogger(CoreService.class);
	@RequestMapping("/pay/payparm")  
    public void payparm(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "openId") String openId){  
        try {  

        	String timeStamps = String.valueOf((System.currentTimeMillis()/1000));//1970年到现在的秒数
    		String out_trade_no = "nkc"+ timeStamps;
    		
    		PayQrCode qrCode = new PayQrCode(Constants.prodID, out_trade_no, openId);

    		String xmlStrp = "<xml><appid>"+qrCode.getAppid()+"</appid><body>LeshuCourse</body><device_info>WEB</device_info><mch_id>"+qrCode.getMch_id()+"</mch_id><nonce_str>123</nonce_str><notify_url>http://leshucq.bceapp.com/mdm/AddQuestions.jsp</notify_url><out_trade_no>"+out_trade_no+"</out_trade_no><sign_type>MD5</sign_type><total_fee>1</total_fee><trade_type>JSAPI</trade_type><openid>"+openId+"</openid><sign>"+qrCode.getSign()+"</sign></xml>";
    		
	    	//String b = PayUtils.generateMchPayNativeRequestURL(Constants.prodID,openId);
	    	HttpsRequest req =  new HttpsRequest();
	    	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", xmlStrp);
	    	log.info("---XMLString From payment request---" + xmlStrp);

    		String[] a =xmlStr.split("prepay_id");
    		String aa =  a[1].substring(10);
    		String prepay_id = aa.substring(0,aa.length()-5);

    		String timeStamp = "12345";  
            String nonceStr = "12345";
            Map<String, String> payMap = new HashMap<String, String>();  

            payMap.put("appId", Constants.APP_ID);  
            payMap.put("timeStamp", timeStamp);  
            payMap.put("nonceStr", nonceStr);  
            payMap.put("signType", "MD5");  
            payMap.put("package", "prepay_id=" + prepay_id);
            
            String paySign = Signature.generateSign(payMap);  
            payMap.put("pg", "prepay_id=" + prepay_id);
            payMap.put("paySign", paySign);
              
            // æ‹¼æŽ¥å¹¶è¿”å›žjson  
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

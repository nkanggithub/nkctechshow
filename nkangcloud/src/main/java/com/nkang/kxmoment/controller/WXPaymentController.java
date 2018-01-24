package com.nkang.kxmoment.controller;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nkang.kxmoment.service.CoreService;
import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.MongoDBBasic;
import com.nkang.kxmoment.util.WeixinPay.bean.PayQrCode;
import com.nkang.kxmoment.util.WeixinPay.bean.Payment;
import com.nkang.kxmoment.util.WeixinPay.utils.HttpsRequest;
import com.nkang.kxmoment.util.WeixinPay.utils.PayUtil;
import com.nkang.kxmoment.util.WeixinPay.utils.Signature;

@Controller
public class WXPaymentController {
	private static Logger log = Logger.getLogger(CoreService.class);
	
	
	@RequestMapping("/pay/payparm")  
    public void payparm(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam(value = "openId") String openId,
    		@RequestParam(value = "totalfee") String totalfee){  
        try {  
        	Date a = new Date();
        	String timeStamps = String.valueOf(a.getTime());
    		String out_trade_no = Constants.clientCode + timeStamps;
    		PayQrCode qrCode = new PayQrCode(Constants.prodID, out_trade_no, openId,totalfee);
    		String xmlStrp = "<xml><appid>"+Constants.APP_ID+"</appid><body>"+Constants.payBody+"</body><device_info>"+Constants.deviceInfo+"</device_info><mch_id>"+Constants.mcthID+"</mch_id><nonce_str>123</nonce_str><notify_url>"+Constants.notifyURL+"</notify_url><out_trade_no>"+out_trade_no+"</out_trade_no><sign_type>"+Constants.signType+"</sign_type><total_fee>"+totalfee+"</total_fee><trade_type>"+Constants.tradeType+"</trade_type><openid>"+openId+"</openid><sign>"+qrCode.getSign()+"</sign></xml>";
	    	HttpsRequest req =  new HttpsRequest();
	    	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", xmlStrp);
	    	String prepay_id = PayUtil.getXmlPara(xmlStr,"prepay_id");
    		String timeStamp = timeStamps;
            String nonceStr = "123";
            Map<String, String> payMap = new HashMap<String, String>();  

            payMap.put("appId", Constants.APP_ID);  
            payMap.put("timeStamp", timeStamp);  
            payMap.put("nonceStr", nonceStr);  
            payMap.put("signType", Constants.signType);  
            payMap.put("package", "prepay_id=" + prepay_id);
            
            String paySign = Signature.generateSign(payMap);  
            payMap.put("pg", "prepay_id=" + prepay_id);
            payMap.put("paySign", paySign);
            
            StringBuilder sBuilder = new StringBuilder("[{");  
            sBuilder.append("appId:'").append(Constants.APP_ID).append("',")  
                        .append("timeStamp:'").append(timeStamp).append("',")  
                        .append("nonceStr:'").append(nonceStr).append("',")  
                        .append("pg:'").append("prepay_id=" + prepay_id).append("',")  
                        .append("signType:'MD5',")  
                        .append("paySign:'").append(paySign).append("'");  
            sBuilder.append("}]");  
            response.getWriter().print(sBuilder.toString());  
            response.getWriter().close();
            
            //Save payment records to database
            Payment pay = new Payment();
            pay.setAppid(Constants.APP_ID);
            pay.setOpenid(openId);
            pay.setMch_id(Constants.mcthID);
            pay.setTotal_fee(totalfee);
            pay.setTransaction_id("TBD");
            pay.setResult_code("TBD");
            pay.setReturn_code("TBD");
            pay.setOut_trade_no(out_trade_no);
            pay.setPrepaypkgID(prepay_id);
            pay.setPayType("WCPay");
            pay.setPayBody(Constants.payBody);
	        Date createdDate = new Date(a.getTime());
	        Format format = new SimpleDateFormat("yyyy MM dd HH:mm:ss");
	        pay.setCreatedDate(format.format(createdDate));

            MongoDBBasic.savePaymentHistory(pay);

         // TOD - Save the data to the database for further query
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
    }
	
	
	@RequestMapping("/pay/payqrparm")  
    public @ResponseBody Payment payqrparm(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam(value = "totalfee") String totalfee){  
		Payment qrpay = new Payment();
		try {

        	Date a = new Date();
        	String timeStamps = String.valueOf(a.getTime());

    		String out_trade_no = Constants.clientCode + timeStamps;
    		PayQrCode qrCode = new PayQrCode(Constants.prodID, out_trade_no, totalfee);
    		String xmlStrp = "<xml><appid>"+Constants.APP_ID+"</appid><body>"+Constants.payBody+"</body><device_info>"+Constants.deviceInfo+"</device_info><mch_id>"+Constants.mcthID+"</mch_id><nonce_str>123</nonce_str><notify_url>"+Constants.notifyURL+"</notify_url><out_trade_no>"+out_trade_no+"</out_trade_no><sign_type>"+Constants.signType+"</sign_type><total_fee>"+totalfee+"</total_fee><trade_type>"+Constants.tradeTypeNative+"</trade_type><sign>"+qrCode.getSign()+"</sign></xml>";
        	HttpsRequest req =  new HttpsRequest();
        	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/unifiedorder", xmlStrp);

        	qrpay.setPrepaypkgID(PayUtil.getXmlPara(xmlStr,"prepay_id"));
        	qrpay.setOut_trade_no(out_trade_no);
        	qrpay.setTotal_fee(totalfee);
        	qrpay.setDevice_info(PayUtil.getXmlPara(xmlStr,"device_info"));
        	qrpay.setResult_code(PayUtil.getXmlPara(xmlStr,"return_msg"));
        	qrpay.setReturn_code(PayUtil.getXmlPara(xmlStr,"return_code"));
        	qrpay.setAppid(PayUtil.getXmlPara(xmlStr,"appid"));
        	qrpay.setMch_id(PayUtil.getXmlPara(xmlStr,"mch_id"));
        	qrpay.setCodeurl(PayUtil.getXmlPara(xmlStr,"code_url"));
        	qrpay.setPayBody(Constants.payBody);
        	qrpay.setOpenid("NA");
        	qrpay.setTransaction_id("NA");
        	qrpay.setPayType("QRScan");
	        Date createdDate = new Date(a.getTime());
	        Format format = new SimpleDateFormat("yyyy MM dd HH:mm:ss");
        	qrpay.setCreatedDate(format.format(createdDate));

            MongoDBBasic.savePaymentHistory(qrpay);

         // TOD - Save the data to the database for further query
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }
        
        return qrpay;
    }
	
	
	@RequestMapping("/pay/orderqueryparm")  
    public void orderqueryparm(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam(value = "openId") String openId,
    		@RequestParam(value = "transactionid") String transactionid,
    		@RequestParam(value = "transactionid") String nonce_str){  
        try {  
        	PayQrCode qrCode = new PayQrCode(transactionid,nonce_str);
        	String xmlStrp = "<xml><appid>"+Constants.APP_ID+"</appid><mch_id>"+Constants.mcthID+"</mch_id><nonce_str>123</nonce_str><transaction_id>"+qrCode.getTransaction_id()+"</transaction_id>><sign>"+qrCode.getSign()+"</sign></xml>";
        	HttpsRequest req =  new HttpsRequest();
        	String xmlStr = req.sendPost("https://api.mch.weixin.qq.com/pay/orderquery", xmlStrp);
        	log.info(xmlStr);
        	// TOD - Save the data to the database for further query
        } catch (Exception e) {  
            e.printStackTrace();  
        }
    }
	
	
}

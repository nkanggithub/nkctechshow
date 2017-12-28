package com.nkang.kxmoment.util.WeixinPay.bean;

import java.util.Map;
import java.util.UUID;

import org.apache.commons.beanutils.BeanUtils;

import com.nkang.kxmoment.util.Constants;
import com.nkang.kxmoment.util.WeixinPay.utils.Configure;
import com.nkang.kxmoment.util.WeixinPay.utils.MapUtil;
import com.nkang.kxmoment.util.WeixinPay.utils.Signature;


/**
 * 
 * @author louiseliu
 *
 */
public class PayQrCode {

	private String appid = "";
	private String mch_id = "";
	private String time_stamp ="";
	private String nonce_str ="";
	private String product_id = "";
	private String sign = "";
	private String body = "";
	private String device_info = "";
	private String notify_url = "";
	private String out_trade_no = "";
	private String sign_type = "";
	private String total_fee = "";
	private String trade_type = "";
	private String openid = "";
	
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getDevice_info() {
		return device_info;
	}

	public void setDevice_info(String device_info) {
		this.device_info = device_info;
	}

	public String getNotify_url() {
		return notify_url;
	}

	public void setNotify_url(String notify_url) {
		this.notify_url = notify_url;
	}

	public String getOut_trade_no() {
		return out_trade_no;
	}

	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}

	public String getSign_type() {
		return sign_type;
	}

	public void setSign_type(String sign_type) {
		this.sign_type = sign_type;
	}

	public String getTotal_fee() {
		return total_fee;
	}

	public void setTotal_fee(String total_fee) {
		this.total_fee = total_fee;
	}

	public String getTrade_type() {
		return trade_type;
	}

	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}

	/**
	 * @param product_id
	 */
	public PayQrCode(String product_id, String out_trade_no){
		setAppid(Configure.getAppid());
		setMch_id(Configure.getMchid());
		//setTime_stamp(System.currentTimeMillis()/1000+"");
		//setNonce_str(UUID.randomUUID().toString().replace("-", ""));
		setNonce_str("123");
		//setProduct_id(product_id);
		setBody("LeshuCourse");
		setDevice_info("WEB");
		setNotify_url("http://leshucq.bceapp.com/mdm/AddQuestions.jsp");
		setOut_trade_no(out_trade_no);
		setSign_type("MD5");
		setTotal_fee("1");
		setTrade_type("JSAPI");
		setOpenid(Constants.devOpenID);
		try {
			Map<String, String> map = BeanUtils.describe(this);
			map.remove("class");
			
			String sign = Signature.generateSign(map);
	        setSign(sign);
		} catch (Exception e) {
		}
	}
	
	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getMch_id() {
		return mch_id;
	}

	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}

	public String getTime_stamp() {
		return time_stamp;
	}

	public void setTime_stamp(String time_stamp) {
		this.time_stamp = time_stamp;
	}

	public String getNonce_str() {
		return nonce_str;
	}

	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
}


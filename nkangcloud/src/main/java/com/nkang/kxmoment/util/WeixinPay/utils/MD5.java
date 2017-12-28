package com.nkang.kxmoment.util.WeixinPay.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author louiseliu
 *
 */
public class MD5 {
    private final static String[] hexDigits = {"0", "1", "2", "3", "4", "5", "6", "7",
            "8", "9", "a", "b", "c", "d", "e", "f"};

    /**
     * 转换字节数组为16进制字串
     * @param b 字节数组
     * @return 16进制字串
     */
    public static String byteArrayToHexString(byte[] b) {
        StringBuilder resultSb = new StringBuilder();
        for (byte aB : b) {
            resultSb.append(byteToHexString(aB));
        }
        return resultSb.toString();
    }

    /**
     * 转换byte到16进制
     * @param b 要转换的byte
     * @return 16进制格式
     */
    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0) {
            n = 256 + n;
        }
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    /**
     * MD5编码
     * @param origin 原始字符串
     * @return 经过MD5加密之后的结果
     */
    public static String MD5Encode(String origin) {
        String resultString = null;
        try {
            resultString = origin;
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(resultString.getBytes("UTF-8"));
            resultString = byteArrayToHexString(md.digest());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultString;
    }
    

    public static String getNonceStr(){
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rd = new Random();
        for(int i = 0 ; i < 32 ; i ++ ){
            sb.append(str.charAt(rd.nextInt(str.length())));
        }
        return sb.toString();
    }
    
    public static String getIpAddr(HttpServletRequest request) {  
        InetAddress addr = null;  
        try {  
            addr = InetAddress.getLocalHost();  
        } catch (UnknownHostException e) {  
            return request.getRemoteAddr();  
        }  
        byte[] ipAddr = addr.getAddress();  
        String ipAddrStr = "";  
        for (int i = 0; i < ipAddr.length; i++) {  
            if (i > 0) {  
                ipAddrStr += ".";  
            }  
            ipAddrStr += ipAddr[i] & 0xFF;  
        }  
        return ipAddrStr;  
    }

}


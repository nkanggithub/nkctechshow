package com.nkang.kxmoment.util.WeixinPay.utils;

import java.security.MessageDigest;

/**
 * 
 * @author louiseliu
 *
 */
public class MD5 {
    private final static String[] hexDigits = {"0", "1", "2", "3", "4", "5", "6", "7",
            "8", "9", "a", "b", "c", "d", "e", "f"};

    /**
     * è½¬æ�¢å­—èŠ‚æ•°ç»„ä¸º16è¿›åˆ¶å­—ä¸²
     * @param b å­—èŠ‚æ•°ç»„
     * @return 16è¿›åˆ¶å­—ä¸²
     */
    public static String byteArrayToHexString(byte[] b) {
        StringBuilder resultSb = new StringBuilder();
        for (byte aB : b) {
            resultSb.append(byteToHexString(aB));
        }
        return resultSb.toString();
    }

    /**
     * è½¬æ�¢byteåˆ°16è¿›åˆ¶
     * @param b è¦�è½¬æ�¢çš„byte
     * @return 16è¿›åˆ¶æ ¼å¼�
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
     * MD5ç¼–ç �
     * @param origin åŽŸå§‹å­—ç¬¦ä¸²
     * @return ç»�è¿‡MD5åŠ å¯†ä¹‹å�Žçš„ç»“æžœ
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

}


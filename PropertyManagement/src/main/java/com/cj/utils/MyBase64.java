package com.cj.utils;

import org.apache.commons.codec.binary.Base64;
/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/30 8:46
 */
/**
 * 加密类
 */
public class MyBase64 {
    /**
     * 返回加密后的字符
     */
    public static String getBase(String s){
        String str=null;
        StringBuffer str1 =new StringBuffer();
        //将字符串转为二进制
        char[] chars = s.toCharArray();
        //添加前置
        str1.append("10010011");
        //循环接收
        for(int i =0;i<chars.length;i++){
            str1.append(Integer.toBinaryString(chars[i]));
        }
        //添加后置
        str1.append("11001001");
        try {
            str= String.valueOf(Base64.encodeBase64String(str1.toString().getBytes()));
            str = "AC"+str+"BD";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return str;
    }
}


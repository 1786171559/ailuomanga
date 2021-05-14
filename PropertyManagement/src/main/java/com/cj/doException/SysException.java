package com.cj.doException;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 11:23
 */
/**
 * 自定义异常类
 */

public class SysException extends Exception {

    // 存储提示信息的
    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public SysException(String message) {
        this.message = message;
    }

}

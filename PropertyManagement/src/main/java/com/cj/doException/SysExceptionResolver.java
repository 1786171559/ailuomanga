package com.cj.doException;

import com.cj.service.ILogInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Date;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 11:24
 */

public class SysExceptionResolver implements HandlerExceptionResolver {

    @Autowired
    ILogInfoService logInfoService;
    private static final Logger LOGGER = LoggerFactory.getLogger(SysExceptionResolver.class);
    /**
     * 跳转到具体的错误页面的方法
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        SysException e = null;
        // 获取到异常对象
        if (ex instanceof SysException) {
            e = (SysException) ex;
        } else {
            e = new SysException("请联系管理员");
        }
        if (handler instanceof HandlerMethod){
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            String className = handlerMethod.getBeanType().getName();
            String methodName = handlerMethod.getMethod().getName();
            logInfoService.addLogInfo(ex.getClass().getSimpleName(),className+"中的"+methodName,
                    "发生时间为："+new Timestamp(new Date().getTime())+";");
        }
        ModelAndView mv = new ModelAndView();
        System.out.println("出错信息："+e.getMessage());
       // logInfoService.addLogInfo();
        // 存入错误的提示信息
        mv.addObject("message", e.getMessage());
        // 跳转的Jsp页面
        mv.setViewName("404");
        return mv;
    }
}


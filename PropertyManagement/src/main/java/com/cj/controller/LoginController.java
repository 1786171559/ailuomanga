package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cj.pojo.House;
import com.cj.pojo.Resources;
import com.cj.pojo.UserInfo;
import com.cj.service.IHouseService;
import com.cj.service.impl.ResourcesServiceImpl;
import com.cj.service.impl.UserInfoServiceImpl;
import com.cj.utils.MyBase64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/13 10:16
 */
@Controller
@RequestMapping("/login")
@SessionAttributes(value = {"loginName", "userName", "userId", "roleNames"})
public class LoginController {
    @Autowired
    private UserInfoServiceImpl userInfoService;
    @Autowired
    private ResourcesServiceImpl resourcesService;
    @Autowired
    private IHouseService houseService;

    /**
     * 提交登录，跳转界面
     *
     * @return
     */
    @RequestMapping("/Logining")
    public ModelAndView Logining(@RequestParam String loginName) {
        //获取当前登录用户信息
        UserInfo userInfo = userInfoService.selectOne(
                new EntityWrapper<UserInfo>().
                        eq("loginName", loginName));
        List<Resources> resources = resourcesService.getAllResourcesByUserId(userInfo.getUserId());

        List<UserInfo> userInfos = userInfoService.selectByLoginName(loginName);
        //创建modelAndView对象
        ModelAndView modelAndView = new ModelAndView("main");
        //往request域和session域中
        // 存储当前用户的：账户和用户名，用户id，用户对应的角色权限,用户对应的资源列表,count为当前用户房子数量
        modelAndView.addObject("loginName", loginName);
        modelAndView.addObject("userName", userInfo.getUserName());
        modelAndView.addObject("userId", userInfos.get(0).getUserId());
        modelAndView.addObject("roleNames", userInfos.get(0).getRoleInfos());
        modelAndView.addObject("resources", resources);
        modelAndView.addObject("count", houseService.selectCount(new EntityWrapper<House>().
                eq("userId", userInfos.get(0).getUserId())));
        return modelAndView;
    }

    /**
     * 登录判断
     * 先判断登录类型
     *
     * @param loginName
     * @param password
     * @return
     */
    @ResponseBody
    @RequestMapping("/logingJudge")
    public Map<String, Object> logingJudge(String loginName, String password) {
        //对密码进行加密
        password = MyBase64.getBase(password);
        //创建Map集合，存储返回结果集
        Map<String, Object> map = new HashMap<String, Object>();
        //根据账户和密码判断是否存在该用户,并且该用户没有被禁用
        int count = userInfoService.selectCount(
                new EntityWrapper<UserInfo>().
                        eq("loginName", loginName).
                        eq("password", password).
                        eq("isEnable", 1).
                        eq("isDelete", 1));
        //根据账户和密码判断是否存在该用户
        int count2 = userInfoService.selectCount(
                new EntityWrapper<UserInfo>().
                        eq("loginName", loginName).
                        eq("password", password).
                        eq("isDelete", 1));
        if (count2 > 0) {
            //如果count大于0，则存在，否则不存在
            if (count > 0) {
                map.put("flag", "success");
            } else {
                //用户已被禁用
                map.put("flag", "userIsForbidden");
            }
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 跳转到登录界面
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/index")
    public void returnToLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}

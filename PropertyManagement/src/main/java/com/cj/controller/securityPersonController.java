package com.cj.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.RoleInfo;
import com.cj.pojo.UserInfo;
import com.cj.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/25 9:11
 */

/**
 * 保安管理
 */
@Controller
@RequestMapping("/securityPerson")
public class securityPersonController {
    @Autowired
    private IUserInfoService userInfoService;

    /**
     * 跳转到业主信息界面
     *
     * @return
     */
    @RequestMapping("/securityPerson-OwnerInfo")
    public String returnJspToOwnerInfo() {
        return "securityPerson-OwnerInfo";
    }

    /**
     * 获取户主信息,并响应回前端
     *
     * @return
     */
    @RequestMapping("/getOwnerInfo")
    @ResponseBody
    public Map<String, Object> getOwnerInfo(Integer page, Integer limit,
                                            @RequestParam(defaultValue = "") String userName,
                                            @RequestParam(defaultValue = "") String sex,
                                            @RequestParam(defaultValue = "") String phone) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //实例化用户信息类
        UserInfo userInfo = new UserInfo();
        //给对象属性赋值
        userInfo.setUserName("%" + userName + "%");
        userInfo.setSex(sex);
        userInfo.setIsDelete(1);
        userInfo.setPhone("%" + phone + "%");
        //分页获取户主信息
        Page<UserInfo> pages = userInfoService.getUserInfoByRoleNameToPage(
                new Page<UserInfo>(page, limit),  userInfo);

        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }
}

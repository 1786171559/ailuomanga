package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.RoleInfo;
import com.cj.pojo.UserInfo;
import com.cj.service.IUserInfoService;
import com.cj.utils.MyBase64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/15 14:10
 */
@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private IUserInfoService userInfoService;

    @RequestMapping("/user-info")
    public String getUserInfo(@RequestParam(defaultValue = "2") Integer pageSize,
                              @RequestParam(defaultValue = "1") Integer currentPage,
                              HttpServletRequest request) {
        return "user-info";
    }

    /**
     * 初始化页面数据---即用户信息
     *
     * @param page
     * @param limit
     * @param userName
     * @param sex
     * @param phone
     * @param request
     * @return
     */
    @RequestMapping("/GetUserInfo")
    @ResponseBody
    public Map<String, Object> GetUserInfo(@RequestParam(defaultValue = "2") Integer page,
                                           @RequestParam(defaultValue = "1") Integer limit,
                                           @RequestParam(defaultValue = "") String userName,
                                           @RequestParam(defaultValue = "") String sex,
                                           @RequestParam(defaultValue = "") String phone,
                                           HttpServletRequest request) {

        Integer userId = (Integer) request.getSession().getAttribute("userId");
        Map<String, Object> map = new HashMap<String, Object>();
        //实例化用户信息类
        UserInfo userInfo = new UserInfo();
        //给对象属性赋值
        //注意：设置用户id是为了不查询该用户
        userInfo.setUserId(userId);
        userInfo.setUserName("%" + userName + "%");
        userInfo.setSex(sex);
        userInfo.setIsDelete(1);
        userInfo.setPhone("%" + phone + "%");
        //根据条件查询用户信息，存储在page对象中
        Page<UserInfo> pages = userInfoService.
                getUserInfoPageByWhere(new Page<UserInfo>(page, limit), userInfo);
        //List集合，获取用户信息
        List<UserInfo> userInfos = pages.getRecords();
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", userInfos);
        map.put("msg", "");
        return map;
    }

    /**
     * 删除单个用户
     */
    /**
     * @param userId
     * @return
     */
    @RequestMapping("/delUserByUserId")
    @ResponseBody
    public Map<String, Object> delUserByUserId(String userId) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //删除单个用户
        if (userInfoService.delete(new EntityWrapper<UserInfo>().eq("userId", Integer.parseInt(userId)))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 删除多个用户
     *
     * @param userIds
     * @return
     */
    @RequestMapping("/delUsersByUserIds")
    @ResponseBody
    public Map<String, Object> delUsersByUserIds(String[] userIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //遍历循环userId，根据userId，删除用户
        for (String userId : userIds) {
            userInfoService.delete(
                    new EntityWrapper<UserInfo>().
                            eq("userId", Integer.parseInt(userId)));
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 根据用户id获取单个用户信息，并跳转到当前用户的编辑页面
     *
     * @param userId
     * @return
     */
    @RequestMapping("/getOneUserById/{userId}")
    public ModelAndView getOneUserById(@PathVariable(name = "userId") Integer userId) {
        //创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView("user-edit");
        //根据userId获取用户信息
        UserInfo userInfo = userInfoService.selectOne(
                new EntityWrapper<UserInfo>().
                        eq("userId", userId));
        //添加到request域中
        modelAndView.addObject("userInfo", userInfo);

        return modelAndView;
    }

    /**
     * 修改用户
     *
     * @param userInfo
     * @return
     */
    @RequestMapping("/changeUser")
    @ResponseBody
    public Map<String, Object> changeUser(UserInfo userInfo) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //更新用户通过id,只更新UserInfo对象不为空字段，更新成功则返回success
        if (userInfoService.update(userInfo, new EntityWrapper<UserInfo>().eq("userId", userInfo.getUserId()))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 新增用户
     *
     * @param userInfo
     * @return
     */
    @RequestMapping("/addUser")
    @ResponseBody
    public Map<String, Object> addUser(UserInfo userInfo) {
        //对密码进行加密
        userInfo.setPassword(MyBase64.getBase(userInfo.getPassword()));
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //如果用户名存在，则返回loginNameIsExit（用户名存在）
        if (userInfoService.selectCount(new EntityWrapper<UserInfo>().
                eq("loginName", userInfo.getLoginName())) > 0) {

            map.put("flag", "loginNameIsExit");

            //如果手机号已注册，则返回phoneIsExit（手机号存在）
        } else if (userInfoService.selectCount(new EntityWrapper<UserInfo>().
                eq("phone", userInfo.getPhone())) > 0) {

            map.put("flag", "phoneIsExit");
        } else {
            //新增用户，成功则返回success，否则返回fail
            if (userInfoService.insert(userInfo)) {

                map.put("flag", "success");

            } else {
                map.put("flag", "fail");
            }
        }
        return map;
    }

    /**
     * 当用户新增列表点击时，跳转到用户新增列界面
     *
     * @return
     */
    @RequestMapping("/user-add")
    public String returnJSPToUserAdd() {
        return "user-add";
    }

    /**
     * 点击用户修改列表时，转向用户列表进行修改
     *
     * @return
     */
    @RequestMapping("/user-change")
    public String changeUserReturnJspToUserInfo() {
        return "user-info";
    }

    /**
     * 获取个人信息
     *
     * @return
     */
    @RequestMapping("/getPesonalInformation/{userId}")
    public ModelAndView getPesonalInformation(@PathVariable(name = "userId") Integer userId) {
        //创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView("personal-information");
        //添加个人信息
        modelAndView.addObject("userInfo",
                userInfoService.selectOne(new EntityWrapper<UserInfo>().
                        eq("userId", userId)));
        return modelAndView;
    }

    /**
     * 修改个人信息
     *
     * @param userInfo
     */
    @RequestMapping("/changePersonalInformation")
    @ResponseBody
    public Map<String, Object> changePersonalInformation(UserInfo userInfo) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //更新用户信息
        if (userInfoService.update(userInfo, new EntityWrapper<UserInfo>().
                eq("userId", userInfo.getUserId()))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 用户修改个人密码
     */
    @RequestMapping("/changePersonalPassword")
    @ResponseBody
    public Map<String, Object> changePersonalPassword(Integer userId, String password) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //实例化UserInfo类
        UserInfo userInfo = new UserInfo();
        //给对象赋值
        userInfo.setUserId(userId);
        userInfo.setPassword(MyBase64.getBase(password));
        //更新密码
        if (userInfoService.update(userInfo, new EntityWrapper<UserInfo>().eq("userId", userId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 通过用户id获取用户信息
     * @param userId
     * @return
     */
    @RequestMapping("/getUserInfoByUserId")
    @ResponseBody
    public Map<String, Object> getUserInfoByUserId(Integer userId) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        map.put("userInfo", userInfoService.selectOne(new EntityWrapper<UserInfo>().
                eq("userId", userId).
                eq("isDelete", 1)));
        map.put("flag", "success");
        return map;
    }
}
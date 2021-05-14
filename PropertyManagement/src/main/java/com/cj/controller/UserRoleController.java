package com.cj.controller;

import com.alibaba.druid.mock.MockArray;
import com.cj.pojo.RoleInfo;
import com.cj.service.IRoleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/18 18:28
 */
@Controller
@RequestMapping("userRole")
public class UserRoleController {
    @Autowired
    private IRoleInfoService roleInfoService;

    @RequestMapping("/do_role/{userId}")
    public ModelAndView getUserRole(@PathVariable(name = "userId") Integer userId) {
        //创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView("user-doRole");
        List<RoleInfo> roleInfos = roleInfoService.getUserRole(userId);
        modelAndView.addObject("userRole",roleInfos);
        modelAndView.addObject("userId",userId);
        return modelAndView;
    }
}

package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cj.pojo.Privilege;
import com.cj.service.IPrivilegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 7:37
 */
@Controller
@RequestMapping("/privilege")
public class PrivilegeController {
    @Autowired
    private IPrivilegeService privilegeService;

    /**
     * 用户分配角色
     *
     * @param userId
     * @param roleId
     */
    @RequestMapping("userDoRole")
    @ResponseBody
    public Map<String, Object> userDoRole(Integer userId, String[] roleId) {
        //创建map对象
        Map<String, Object> map = new HashMap<>();
        //删除当前用户的角色
        privilegeService.delete(new EntityWrapper<Privilege>().eq("userId", userId));
        //重新分配角色
        for (String roleid : roleId) {
            Privilege privilege = new Privilege();
            privilege.setRoleId(Integer.parseInt(roleid));
            privilege.setUserId(userId);
            privilegeService.insert(privilege);
        }
        map.put("flag", "success");
        return map;
    }
}

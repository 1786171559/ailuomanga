package com.cj.service;

import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.RoleInfo;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:43
 */
public interface IRoleInfoService extends IService<RoleInfo> {
    /**
     * 通过用户id获取角色信息，便于判断该用户是否有此角色
     * @return
     */
    public List<RoleInfo> getUserRole(Integer userId);


    /**
     * 角色人数统计
     * @return
     */
    public List<RoleInfo> getRoleCountToGroupBy();
}

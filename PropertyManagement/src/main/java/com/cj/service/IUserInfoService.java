package com.cj.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.UserInfo;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:42
 */
public interface IUserInfoService extends IService<UserInfo> {
    /**
     * 通过账户查询当前用户所具备的用户信息和角色信息
     *
     * @param loginName 账户
     * @return
     */
    public List<UserInfo> selectByLoginName(String loginName);

    /**
     * 分页查询用户信息
     *
     * @param page
     * @param userInfo
     * @return
     */
    public Page<UserInfo> getUserInfoPageByWhere(Page<UserInfo> page, UserInfo userInfo);

    /**
     * 通过角色名称查询用户
     *
     * @param roleName
     * @return
     */
    public List<UserInfo> getUserInfoByRoleName(String roleName);

    /**
     * 在角色为户主的情况下通过条件分页查询用户
     *
     * @return
     */
    public Page<UserInfo> getUserInfoByRoleNameToPage(Page<UserInfo> page,UserInfo userInfo);
}

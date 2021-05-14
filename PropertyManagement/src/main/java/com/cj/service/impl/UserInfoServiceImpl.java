package com.cj.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.UserInfoMapper;
import com.cj.pojo.UserInfo;
import com.cj.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:43
 */
@Service("userInfoService")
@Transactional
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {
    @Autowired
    private UserInfoMapper userInfoDao;

    /**
     * 通过账户查询当前用户所具备的用户信息和角色信息
     *
     * @param loginName 账户
     * @return
     */
    @Override
    public List<UserInfo> selectByLoginName(String loginName) {
        return userInfoDao.selectByLoginName(loginName);
    }

    /**
     * 分页查询用户信息
     *
     * @param page
     * @param userInfo
     * @return
     */
    @Override
    public Page<UserInfo> getUserInfoPageByWhere(Page<UserInfo> page, UserInfo userInfo) {
        return page.setRecords(userInfoDao.selectUsersByWhere(page, userInfo));
    }

    /**
     * 通过角色名称查询用户
     *
     * @param roleName
     * @return
     */
    @Override
    public List<UserInfo> getUserInfoByRoleName(String roleName) {
        return userInfoDao.getUserInfoByRoleName(roleName);
    }
    /**
     * 在角色为户主的情况下通过条件分页查询用户
     *
     * @return
     */
    @Override
    public Page<UserInfo> getUserInfoByRoleNameToPage(Page<UserInfo> page,UserInfo userInfo) {
        return page.setRecords(userInfoDao.getUserInfoByRoleNameToPage(page,userInfo));
    }
}

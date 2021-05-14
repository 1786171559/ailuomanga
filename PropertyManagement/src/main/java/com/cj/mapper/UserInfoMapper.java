package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.cj.pojo.UserInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:38
 */
@Repository("userInfoDao")
public interface UserInfoMapper extends BaseMapper<UserInfo> {
    /**
     * 通过账户查询当前用户所具备的用户信息和角色信息
     *
     * @param loginName 账户
     * @return
     */
    public List<UserInfo> selectByLoginName(String loginName);

    /**
     * 通过条件进行查询
     *
     * @param page
     * @param userInfo
     * @return
     */
    public List<UserInfo> selectUsersByWhere(Pagination page, UserInfo userInfo);

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
    public List<UserInfo> getUserInfoByRoleNameToPage(Pagination page,UserInfo userInfo);

}

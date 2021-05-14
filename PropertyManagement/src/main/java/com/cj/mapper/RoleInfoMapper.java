package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.RoleInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:40
 */
@Repository("roleInfoDao")
public interface RoleInfoMapper extends BaseMapper<RoleInfo> {
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

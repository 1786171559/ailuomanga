package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.RoleInfoMapper;
import com.cj.pojo.RoleInfo;
import com.cj.service.IRoleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:45
 */
@Service("roleInfoService")
@Transactional
public class RoleInfoServiceImpl extends ServiceImpl<RoleInfoMapper, RoleInfo> implements IRoleInfoService {
    @Autowired
    private RoleInfoMapper roleInfoDao;

    /**
     * 通过用户id获取角色信息，便于判断该用户是否有此角色
     *
     * @return
     */
    @Override
    public List<RoleInfo> getUserRole(Integer userId) {
        return roleInfoDao.getUserRole(userId);
    }

    @Override
    public List<RoleInfo> getRoleCountToGroupBy() {
        return roleInfoDao.getRoleCountToGroupBy();
    }
}

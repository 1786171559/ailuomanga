package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.RoleResourceMapper;
import com.cj.pojo.RoleResource;
import com.cj.service.IRoleResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 10:41
 */
@Service("roleResourceService")
@Transactional
public class RoleResourceServiceImpl extends ServiceImpl<RoleResourceMapper, RoleResource> implements IRoleResourceService {
    @Autowired
    private RoleResourceMapper roleResourceDao;
    @Override
    public void deleteRoleResources(Integer roleId,Integer resId,Integer parentId) {
        roleResourceDao.deleteRoleResources(roleId,resId,parentId);
    }
}

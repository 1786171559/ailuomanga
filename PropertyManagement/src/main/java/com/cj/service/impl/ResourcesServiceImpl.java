package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.ResourcesMapper;
import com.cj.pojo.Resources;
import com.cj.service.IResourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/15 9:29
 */
@Service("resourcesService")
@Transactional
public class ResourcesServiceImpl extends ServiceImpl<ResourcesMapper, Resources> implements IResourcesService {
    @Autowired
   private ResourcesMapper resourcesDao;
    @Override
    public List<Resources> getAllResourcesByUserId(Integer userId) {
        return resourcesDao.getAllResourcesByUserId(userId);
    }

    @Override
    public List<Resources> getRoleReSourcesByRoleId(Integer roleId) {
        return resourcesDao.getRoleReSourcesByRoleId(roleId);
    }

    @Override
    public List<Resources> getResourceChild(Integer resId) {
        return resourcesDao.getResourceChild(resId);
    }

    @Override
    public List<Resources> getResources() {
        return resourcesDao.getResources();
    }
}

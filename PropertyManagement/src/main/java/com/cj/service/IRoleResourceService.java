package com.cj.service;

import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.RoleResource;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 10:40
 */
public interface IRoleResourceService extends IService<RoleResource> {
    /**
     * 删除角色资源
     */
    public void deleteRoleResources(Integer roleId,Integer resId,Integer parentId);
}

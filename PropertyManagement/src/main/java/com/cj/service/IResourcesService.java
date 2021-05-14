package com.cj.service;

import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.Resources;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/15 9:29
 */
public interface IResourcesService extends IService<Resources> {
    /**
     * 获取当前用户的资源
     * @param userId
     * @return
     */
    List<Resources> getAllResourcesByUserId(Integer userId);

    /**
     * 通过角色id获取资源列表
     */
    List<Resources> getRoleReSourcesByRoleId(Integer roleId);

    /**
     * 获取目录下的子目录
     * @param resId
     * @return
     */
    List<Resources> getResourceChild(Integer resId);

    /**
     * 获取资源信息
     * @return
     */
    List<Resources> getResources();
}

package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.Resources;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/15 9:28
 */
@Repository("resourcesDao")
public interface ResourcesMapper extends BaseMapper<Resources> {
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

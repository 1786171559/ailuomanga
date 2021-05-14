package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.RoleResource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 10:40
 */
@Repository("roleResourceDao")
public interface RoleResourceMapper extends BaseMapper<RoleResource> {
    /**
     * 删除角色资源
     */
    public void deleteRoleResources(@Param("roleId") Integer roleId,
                                    @Param("resId")Integer resId,
                                    @Param("parentId")Integer parentId);

}

package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.Privilege;
import org.springframework.stereotype.Repository;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 7:35
 */
@Repository("privilegeDao")
public interface PrivilegeMapper extends BaseMapper<Privilege> {
}

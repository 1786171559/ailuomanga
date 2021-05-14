package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.PrivilegeMapper;
import com.cj.pojo.Privilege;
import com.cj.service.IPrivilegeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 7:36
 */
@Service("privilegeService")
@Transactional
public class PrivilegeServiceImpl extends ServiceImpl<PrivilegeMapper, Privilege> implements IPrivilegeService {

}

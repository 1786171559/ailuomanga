package com.cj.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.MaintainMapper;
import com.cj.pojo.House;
import com.cj.pojo.Maintain;
import com.cj.service.IMaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:23
 */
@Service("maintainService")
@Transactional
public class MaintainServiceImpl extends ServiceImpl<MaintainMapper, Maintain> implements IMaintainService {
    @Autowired
    private MaintainMapper maintainDao;

    @Override
    public Page<Maintain> getMainPageByWhere(Page<Maintain> page, Maintain maintain) {
        return page.setRecords(maintainDao.selectMainTainByWhere(page, maintain));
    }

    @Override
    public Maintain selectOneMaintainByMaintainId(Integer maintainId) {
        return maintainDao.selectOneMaintainByMaintainId(maintainId);
    }

    @Override
    public Page<Maintain> selectMaintainInfoByRepairId(Page<Maintain> page, Integer repairId) {
        return page.setRecords(maintainDao.selectMaintainInfoByRepairId(page, repairId));
    }
}

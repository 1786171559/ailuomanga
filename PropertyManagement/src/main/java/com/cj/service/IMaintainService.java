package com.cj.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.House;
import com.cj.pojo.Maintain;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:23
 */
public interface IMaintainService extends IService<Maintain> {
    /**
     * 分页查询维修信息
     *
     * @param page
     * @param maintain
     * @return
     */
    public Page<Maintain> getMainPageByWhere(Page<Maintain> page, Maintain maintain);

    /**
     * 通过id获取维修信息
     * @param maintainId
     * @return
     */
    public Maintain selectOneMaintainByMaintainId(Integer maintainId);
    //selectMaintainInfoByRepairId
    public Page<Maintain> selectMaintainInfoByRepairId(Page<Maintain> page,Integer repairId);
}

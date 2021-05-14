package com.cj.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.House;


/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/20 18:54
 */
public interface IHouseService extends IService<House> {
    /**
     * 分页查询用户信息
     *
     * @param page
     * @param house
     * @return
     */
    public Page<House> getHousePageByWhere(Page<House> page, House house);

    /**
     * 业主获取个人房屋信息
     *
     * @param house
     * @return
     */
    public Page<House> selectOwnerHouseInfoByWhere(Page<House> page,House house);
}

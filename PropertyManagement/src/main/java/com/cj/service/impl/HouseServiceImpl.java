package com.cj.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.HouseMapper;
import com.cj.pojo.House;
import com.cj.service.IHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/20 18:55
 */
@Service("houseService")
@Transactional
public class HouseServiceImpl extends ServiceImpl<HouseMapper, House> implements IHouseService {
    @Autowired
    private HouseMapper houseDao;
    /**
     * 分页查询用户信息
     *
     * @param page
     * @param house
     * @return
     */
    @Override
    public Page<House> getHousePageByWhere(Page<House> page, House house) {
        return page.setRecords(houseDao.selectHouseInfoByWhere(page,house));
    }
    /**
     * 业主获取个人房屋信息
     *
     * @param house
     * @return
     */
    @Override
    public Page<House> selectOwnerHouseInfoByWhere(Page<House> page,House house) {
        return page.setRecords(houseDao.selectOwnerHouseInfoByWhere(page,house));
    }
}

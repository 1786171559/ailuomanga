package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.cj.pojo.House;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/20 18:32
 */
@Repository("houseDao")
public interface HouseMapper extends BaseMapper<House> {
    /**
     * 通过条件分页查询房屋信息
     *
     * @param page
     * @param house
     * @return
     */
    public List<House> selectHouseInfoByWhere(Pagination page, House house);

    /**
     * 业主获取个人房屋信息
     *
     * @param house
     * @return
     */
    public List<House> selectOwnerHouseInfoByWhere(Pagination page, House house);
}

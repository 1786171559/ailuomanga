package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.cj.pojo.House;
import com.cj.pojo.Maintain;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:22
 */
@Repository("maintainDao")
public interface MaintainMapper extends BaseMapper<Maintain> {
    /**
     * 通过条件动态分页获取维修信息
     * @param page
     * @param maintain
     * @return
     */
    public List<Maintain> selectMainTainByWhere(Pagination page,Maintain maintain);

    /**
     * 通过id获取维修信息
     * @param maintainId
     * @return
     */
    public Maintain selectOneMaintainByMaintainId(Integer maintainId);

    /**
     * 根据维修人员id获取维修信息
     * @param page
     * @param repairId
     * @return
     */
    public List<Maintain> selectMaintainInfoByRepairId(Pagination page,Integer repairId);
}

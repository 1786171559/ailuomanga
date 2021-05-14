package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.cj.pojo.DoComplaint;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 18:49
 */
@Repository("doComplaintDao")
public interface DoComplaintMapper extends BaseMapper<DoComplaint> {
    /**
     * 分页获取投诉信息
     * @return
     */
   public List<DoComplaint> selectComplaintInfoByWhere(Pagination page,DoComplaint doComplaint);
}

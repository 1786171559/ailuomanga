package com.cj.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.DoComplaint;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 20:34
 */
public interface IDoComplaintService extends IService<DoComplaint> {
    /**
     * 分页获取投诉信息
     *
     * @return
     */
    public Page<DoComplaint> selectComplaintInfoByWhere(Page<DoComplaint> page, DoComplaint doComplaint);
}

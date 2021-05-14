package com.cj.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.DoComplaintMapper;
import com.cj.pojo.DoComplaint;
import com.cj.service.IDoComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 20:46
 */
@Service("doComplaintService")
public class DoComplaintServiceImpl extends ServiceImpl<DoComplaintMapper,DoComplaint> implements IDoComplaintService {
    @Autowired
    private DoComplaintMapper doComplaintDao;

    /**
     * 分页获取投诉信息
     *
     * @return
     */
    @Override
    public Page<DoComplaint> selectComplaintInfoByWhere(Page<DoComplaint> page, DoComplaint doComplaint) {
        return page.setRecords(doComplaintDao.selectComplaintInfoByWhere(page, doComplaint));

    }
}

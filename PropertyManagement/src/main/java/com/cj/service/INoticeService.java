package com.cj.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.IService;
import com.cj.pojo.House;
import com.cj.pojo.Notice;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 20:33
 */
public interface INoticeService extends IService<Notice> {

    public Page<Notice> selectNoticeOrderByPublishDate(Page<Notice> page);
}

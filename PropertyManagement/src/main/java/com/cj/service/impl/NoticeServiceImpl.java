package com.cj.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.NoticeMapper;
import com.cj.pojo.Notice;
import com.cj.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 20:34
 */
@Service("noticeService")
@Transactional
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements INoticeService {
    @Autowired
    private NoticeMapper noticeDao;

    @Override
    public Page<Notice> selectNoticeOrderByPublishDate(Page<Notice> page) {
        return page.setRecords(noticeDao.selectNoticeOrderByPublishDate(page));
    }
}

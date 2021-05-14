package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.cj.pojo.Notice;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 20:33
 */
@Repository("noticeDao")
public interface NoticeMapper extends BaseMapper<Notice> {
    public List<Notice> selectNoticeOrderByPublishDate(Pagination page);
}

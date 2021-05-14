package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.Complaint;
import org.springframework.stereotype.Repository;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 21:23
 */
@Repository("complaintDao")
public interface ComplaintMapper extends BaseMapper<Complaint> {
}

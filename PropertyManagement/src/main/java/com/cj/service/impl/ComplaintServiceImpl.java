package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.ComplaintMapper;
import com.cj.pojo.Complaint;
import com.cj.service.IComplaintService;
import org.springframework.stereotype.Service;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 21:24
 */
@Service("complaintService")
public class ComplaintServiceImpl extends ServiceImpl<ComplaintMapper, Complaint> implements IComplaintService {
}

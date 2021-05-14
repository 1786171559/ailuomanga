package com.cj.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cj.mapper.TaskMapper;
import com.cj.pojo.Task;
import com.cj.service.ITaskService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 8:58
 */
@Service("taskService")
@Transactional
public class TaskServiceImpl extends ServiceImpl<TaskMapper, Task> implements ITaskService {
}

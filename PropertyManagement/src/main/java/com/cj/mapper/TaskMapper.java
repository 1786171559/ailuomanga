package com.cj.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cj.pojo.Task;
import org.springframework.stereotype.Repository;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 8:57
 */
@Repository("taskDao")
public interface TaskMapper extends BaseMapper<Task> {
}

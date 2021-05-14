package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:09
 */
//任务表
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Task {
    //编号
    @TableId(value = "taskId", type = IdType.AUTO)
    private Integer taskId;
    //任务类型
    private String taskType;
}

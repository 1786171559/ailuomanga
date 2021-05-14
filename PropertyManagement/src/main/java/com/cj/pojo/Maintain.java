package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.FieldStrategy;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;
import java.util.Date;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:04
 */

/**
 * 维修表
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Maintain {
    //维修id
    @TableId(value = "maintainId", type = IdType.AUTO)
    private Integer maintainId;
    //描述
    private String description;
    //任务id
    private Integer taskId;
    //发生时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @TableField(fill = FieldFill.INSERT)
    private Date occurredTime;
    //处理时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    private Date processingTime;
    //完成时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    private Date finishTime;
    //评价得分
    private Double score;
    //处理人id
    private Integer repairId;
    //用户id
    private Integer userId;

    @TableField(exist = false)
    private Task task;
    @TableField(exist = false)
    private UserInfo userInfo;

}

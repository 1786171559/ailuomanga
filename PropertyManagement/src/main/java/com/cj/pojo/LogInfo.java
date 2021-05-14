package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableId;
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
 * @date 2021/4/28 11:25
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LogInfo {
    @TableId(value = "logId", type = IdType.AUTO)
    private Integer logId;
    private String logType;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    private Timestamp createTime;
    private String appendAddress;
    private String description;

}

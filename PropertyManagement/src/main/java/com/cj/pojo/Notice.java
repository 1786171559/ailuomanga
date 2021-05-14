package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Timestamp;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 20:30
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
    private Integer noticeId;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    private Timestamp publishDate;
    private String title;
    private Integer userId;
    @TableField(exist = false)
    private UserInfo userInfo;
}

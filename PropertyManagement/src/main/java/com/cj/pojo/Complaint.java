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
 * @date 2021/4/28 18:42
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
//投诉表
public class Complaint {
    //投诉id
    @TableId(value = "complaintId", type = IdType.AUTO)
    private Integer complaintId;
    //投诉类型
    private String complaintType;
}

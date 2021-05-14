package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 18:44
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
//进行投诉类
public class DoComplaint {
    //进行投诉id
    @TableId(value = "doComplaintId", type = IdType.AUTO)
    private Integer doComplaintId;
    //投诉id
    private Integer complaintId;
    //投诉人
    private String complainter;
    //投诉人电话
    private String complainPhone;
    //投诉内容
    private String complaintContent;
    //处理人
    private String handlingPerson;
    //处理人电话
    private String handlingPhone;
    //状态
    private String isComplete;

    @TableField(exist = false)
    private Complaint complaint;
}

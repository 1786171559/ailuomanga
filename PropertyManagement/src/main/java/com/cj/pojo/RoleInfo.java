package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:32
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleInfo {
    //角色id
    @TableId(value = "roleId", type = IdType.AUTO)
    private Integer roleId;
    //角色名称
    private String roleName;
    @TableLogic // 逻辑删除属性
    private Integer isDelete;

    //用于统计角色人数
    @TableField(exist = false)
    private Integer count;

    @TableField(exist = false)
    private Privilege privilege;
}

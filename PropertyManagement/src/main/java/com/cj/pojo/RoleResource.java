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
 * @date 2021/4/19 10:38
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleResource {
    @TableId(value = "rsId", type = IdType.AUTO)
    private Integer rsId;
    private Integer resId;
    private Integer roleId;
}

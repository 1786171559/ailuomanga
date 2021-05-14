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
 * @date 2021/4/18 18:33
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Privilege {
    @TableId(value = "pid", type = IdType.AUTO)
    private Integer pid;
    private Integer roleId;
    private Integer userId;
}

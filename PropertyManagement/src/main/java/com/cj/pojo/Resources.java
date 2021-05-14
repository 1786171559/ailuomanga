package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/15 9:24
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Resources {
    @TableId(value = "resId", type = IdType.AUTO)
    private Integer resId;
    private String resName;
    private Integer resLevel;
    private String resUrl;
    private Integer parentId;
    private Integer isEnable;

    @TableField(exist = false)
    private List<Reso> resos;

    @TableField(exist = false)
    private RoleResource roleResource;

    @TableField(exist = false)
    private Reso reso;
}

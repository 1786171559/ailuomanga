package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableLogic;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/14 17:35
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfo {
    private Integer userId;
    private String userName;
    private String loginName;
    private String password;
    private String sex;
    private Integer age;
    private String phone;
    private String address;
    private String carId;
    private Integer isEnable;
    @TableLogic // 逻辑删除属性
    private Integer isDelete;
    @TableField(exist = false)
    private List<RoleInfo> roleInfos;
}

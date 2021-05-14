package com.cj.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/20 17:36
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
/**
 * 房产表
 */
public class House {
    //编号
    @TableId(value = "houseId", type = IdType.AUTO)
    private Integer houseId;
    //门牌号
    private String houseNum;
    //楼号
    private String deptNum;
    //类型
    private String houseType;
    //地址
    private String address;
    //出售状态
    private String sellStatus;
    //朝向
    private String direction;
    //备注
    private String memo;
    //是否删除
    @TableLogic // 逻辑删除属性
    private Integer isDelete;
    //用户id
    private Integer userId;

    @TableField(exist = false)
    private UserInfo userInfo;
}

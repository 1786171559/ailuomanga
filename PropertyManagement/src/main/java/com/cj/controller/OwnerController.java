package com.cj.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.House;
import com.cj.pojo.Maintain;
import com.cj.service.IHouseService;
import com.cj.service.IMaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/23 14:37
 */
@Controller
@RequestMapping("/owner")
public class OwnerController {

    @Autowired
    private IHouseService houseService;
    @Autowired
    private IMaintainService maintainService;

    /**
     * 跳转到业主界面
     *
     * @return
     */
    @RequestMapping("/owner-house")
    public String returnJspToHouseInfo() {
        return "owner-house";
    }




    /**
     * 分页获取业主房屋信息
     *
     * @return
     */
    @RequestMapping("/getOwnerHouseInfo")
    @ResponseBody
    public Map<String, Object> getOwnerHouseInfo(Integer page,
                                                 Integer limit,
                                                 House house,
                                                 HttpServletRequest request) {
        //获取用户id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        house.setUserId(userId);


        //设置删除状态为未删除
        house.setIsDelete(1);
        //如果地址不为空
        if (house.getAddress() != null && !("").equals(house.getAddress())) {
            //设置模糊查询字段
            house.setAddress("%" + house.getAddress() + "%");
        }
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        Page<House> pages = houseService.selectOwnerHouseInfoByWhere(new Page<House>(page, limit), house);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 跳转到户主维修界面
     *
     * @return
     */
    @RequestMapping("/person-doMaintain")
    public String returnJspToPersonDoMain() {
        return "person-doMaintain";
    }

    /**
     * 获取户主报修信息
     */
    @RequestMapping("/getOwnerMainInfo")
    @ResponseBody
    public Map<String, Object> getOwnerMainInfo(Integer page, Integer limit, Maintain maintain, HttpServletRequest request) {
        //获取用户id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //设置报修订单的用户id
        maintain.setUserId(userId);
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Maintain> pages = maintainService.getMainPageByWhere(
                new Page<Maintain>(page, limit), maintain);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }
}

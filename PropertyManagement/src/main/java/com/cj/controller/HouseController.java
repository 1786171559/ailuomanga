package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.House;
import com.cj.service.IHouseService;
import com.cj.service.IUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/20 18:57
 */
@Controller
@RequestMapping("/house")
public class HouseController {
    @Autowired
    private IHouseService houseService;
    @Autowired
    private IUserInfoService userInfoService;

    @RequestMapping("/house-info")
    public String returnJspToHouse() {
        return "house-info";
    }

    /**
     * 获取房产信息
     */
    @RequestMapping("/getHouseInfo")
    @ResponseBody
    public Map<String, Object> getHouseInfo(@RequestParam(defaultValue = "1") Integer page,
                                            @RequestParam(defaultValue = "10") Integer limit,
                                            House house) {
        //如果地址不为空
        if (house.getAddress() != null && !("").equals(house.getAddress())) {
            //设置模糊查询字段
            house.setAddress("%" + house.getAddress() + "%");
        }
        //设置房子的删除状态
        house.setIsDelete(1);
        //根据条件动态分页查询房产信息
        Page<House> pages = houseService.getHousePageByWhere(new Page<House>(page, limit), house);
        //list集合，获取房产信息
        List<House> houses = pages.getRecords();
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", houses);
        map.put("msg", "");
        return map;
    }

    /**
     * 通过房产id删除单条房产信息
     *
     * @param houseId
     */
    @RequestMapping("/delHouseByHouseId")
    @ResponseBody
    public Map<String, Object> delHouseByHouseId(Integer houseId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (houseService.delete(new EntityWrapper<House>().eq("houseId", houseId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 通过房产ids删除多条房产信息
     *
     * @param houseIds 房子ids
     */
    @RequestMapping("/delHousesByHouseIds")
    @ResponseBody
    public Map<String, Object> delHousesByHouseIds(Integer[] houseIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        for (Integer houseId : houseIds) {
            houseService.delete(new EntityWrapper<House>().eq("houseId", houseId));
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 编辑按钮点击时,获取当前对象房产信息
     *
     * @param houseId
     */
    @RequestMapping("/getOneHouseById/{houseId}")
    public ModelAndView getOneHouseById(@PathVariable(name = "houseId") Integer houseId) {
        ModelAndView modelAndView = new ModelAndView("house-edit");

        //通过id获取当前对象的房产信息,并存入request域中
        modelAndView.addObject("house",
                houseService.selectOne(new EntityWrapper<House>().eq("houseId", houseId)));

        //查询为户主的用户信息
        modelAndView.addObject("userInfo", userInfoService.getUserInfoByRoleName("户主"));
        return modelAndView;
    }

    /**
     * 通过房屋id修改房屋信息
     *
     * @param house
     */
    @RequestMapping("/changeHouse")
    @ResponseBody
    public Map<String, Object> changeHouse(House house) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (houseService.update(house, new EntityWrapper<House>().eq("houseId", house.getHouseId()))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 新增房屋信息,新增前判断该房屋是否存在
     *
     * @param house
     * @return
     */
    @RequestMapping("/addHouse")
    @ResponseBody
    public Map<String, Object> addHouse(House house) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //判断该房屋是否存在
        if (houseService.selectCount(new EntityWrapper<House>().
                eq("houseNum", house.getHouseNum()).
                eq("deptNum", house.getDeptNum()).
                eq("address", house.getAddress())) > 0) {
            map.put("flag", "houseIsExit");
        } else {
            //新增房子
            if (houseService.insert(house)) {
                map.put("flag", "success");
            } else {
                map.put("flag", "fail");
            }
        }
        return map;
    }

    /**
     * 跳转jsp页面,页面为房屋新增
     *
     * @return
     */
    @RequestMapping("/house-add")
    public String returnJspToHouseAdd() {
        return "house-add";
    }

    /**
     * 跳转jsp页面,页面为房屋修改
     *
     * @return
     */

    public String returnJspToHouseChange() {
        return "house-info";
    }

    /**
     * 跳转jsp页面,页面为房屋修改
     *
     * @return
     */
    @RequestMapping("/MyHouse")
    public ModelAndView returnJspToMyHouse(HttpServletRequest request) {
        //创建modelAndView对象
        ModelAndView modelAndView = new ModelAndView("Myhouse");
        //获取用户id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //获取用户房产信息
        List<House> houses = houseService.selectList(new EntityWrapper<House>().eq("userId", userId).
                eq("isDelete", 1));
        modelAndView.addObject("houses", houses);
        return modelAndView;
    }
}

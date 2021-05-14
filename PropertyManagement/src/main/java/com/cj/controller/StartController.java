package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cj.pojo.DoComplaint;
import com.cj.pojo.House;
import com.cj.pojo.Maintain;
import com.cj.pojo.RoleInfo;
import com.cj.service.IDoComplaintService;
import com.cj.service.IHouseService;
import com.cj.service.IMaintainService;
import com.cj.service.IRoleInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/27 21:10
 */
@Controller
@RequestMapping("/start")
public class StartController {
    @Autowired
    private IHouseService houseService;
    @Autowired
    private IRoleInfoService roleInfoService;
    @Autowired
    private IMaintainService maintainService;
    @Autowired
    private IDoComplaintService doComplaintService;
    /**
     * 进入登录界面后，跳转到success界面，即初始化界面
     * 在方法中 获取房屋：销售情况  获取报修：已办、未办    获取投诉：已办、未办
     *
     * @return
     */
    @RequestMapping("/success")
    public ModelAndView returnJspToSuccess() {

        ModelAndView modelAndView = new ModelAndView("success");
        //获取房屋：销售情况
        modelAndView.addObject("sellOne", houseService.selectCount(new EntityWrapper<House>().
                eq("sellStatus", "已售").eq("isDelete", 1)));
        modelAndView.addObject("sellTow", houseService.selectCount(new EntityWrapper<House>().
                eq("sellStatus", "待售").eq("isDelete", 1)));
        //获取报修：已办、未办
        //未办
        modelAndView.addObject("doThing",maintainService.selectCount(new EntityWrapper<Maintain>()
                .eq("finishTime","0000-00-00 00:00:00")));
        //已办
        modelAndView.addObject("doneThing",maintainService.selectCount(new EntityWrapper<Maintain>()
                .ne("finishTime","0000-00-00 00:00:00")));
        //获取投诉：已办、未办
        //未办
        modelAndView.addObject("doComplaint",doComplaintService.selectCount
                (new EntityWrapper<DoComplaint>().ne("isComplete","已处理")));
        //已办
        modelAndView.addObject("doneComplaint",doComplaintService.selectCount
                (new EntityWrapper<DoComplaint>().eq("isComplete","已处理")));
        return modelAndView;
    }

    /**
     * 获取各人员数量
     * @return
     */
    @RequestMapping("/getPeopleCount")
    @ResponseBody
    public Map<String, Object> getPeopleCount() {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("roleInfos",roleInfoService.getRoleCountToGroupBy());
        return map;
    }
}

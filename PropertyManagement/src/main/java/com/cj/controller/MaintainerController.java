package com.cj.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.Maintain;
import com.cj.pojo.UserInfo;
import com.cj.service.IMaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/25 10:22
 */
@Controller
@RequestMapping("/maintainer")
public class MaintainerController {
    @Autowired
    private IMaintainService maintainService;

    /**
     * 跳转到维修信息界面
     * @return
     */
    @RequestMapping("/showMaintain")
    public String returnJspToMaintainer() {
        return "showMaintain";
    }

    /**
     * 获取维修信息
     * @param page
     * @param limit
     * @param request
     * @return
     */
    @RequestMapping("/getMainInfoByRepairId")
    @ResponseBody
    public Map<String, Object> getMainInfoByRepairId(Integer page, Integer limit, HttpServletRequest request) {
        //获取用户id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Maintain> pages = maintainService.
                selectMaintainInfoByRepairId(new Page<Maintain>(page, limit), userId);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 点击完成按钮时，更新当前对象维修信息，更新完成时间
     * @param maintainId
     * @return
     */
    @RequestMapping("/completeRepair")
    @ResponseBody
    public Map<String,Object> completeRepair(Integer maintainId){
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //创建维修类对象
        Maintain maintain = new Maintain();
        maintain.setMaintainId(maintainId);
        //更新完成时间
        maintain.setFinishTime(new Timestamp(new Date().getTime()));
        if (maintainService.updateById(maintain)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }



}

package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.Complaint;
import com.cj.pojo.DoComplaint;
import com.cj.pojo.UserInfo;
import com.cj.service.IComplaintService;
import com.cj.service.IDoComplaintService;
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
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 20:51
 */
@Controller
@RequestMapping("/intelligenceService")
public class IntelligenceServiceController {
    @Autowired
    private IDoComplaintService doComplaintService;
    @Autowired
    private IComplaintService complaintService;
    @Autowired
    private IUserInfoService userInfoService;

    /**
     * 跳转到投诉信息界面
     *
     * @return
     */
    @RequestMapping("/complaintInfo")
    public ModelAndView returnJspToComplaintInfo() {
        ModelAndView modelAndView = new ModelAndView("complaintInfo");
        modelAndView.addObject("complaintinfos", complaintService.selectList(null));
        return modelAndView;
    }

    /**
     * 获取投诉信息
     */
    @RequestMapping("/getComplaintInfo")
    @ResponseBody
    public Map<String, Object> getComplaintInfo(@RequestParam Integer page,
                                                @RequestParam Integer limit,
                                                DoComplaint doComplaint) {
        //如果地址不为空
        if (doComplaint.getComplainter() != null && !("").equals(doComplaint.getComplainter())) {
            //设置模糊查询字段
            doComplaint.setComplainter("%" + doComplaint.getComplainter() + "%");
        }
        Map<String, Object> map = new HashMap<String, Object>();
        //根据条件获取投诉信息
        Page<DoComplaint> pages = doComplaintService.selectComplaintInfoByWhere(
                new Page<DoComplaint>(page, limit), doComplaint);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 跳转到投诉新增界面
     *
     * @return
     */
    @RequestMapping("/complaint-add")
    public ModelAndView returnJspToComplaintAdd() {
        ModelAndView modelAndView = new ModelAndView("complaint-add");
        modelAndView.addObject("complaintinfos", complaintService.selectList(null));
        return modelAndView;
    }

    /**
     * 新增投诉
     */
    @RequestMapping("/addComplaintInfo")
    @ResponseBody
    public Map<String, Object> addComplaintInfo(DoComplaint doComplaint, HttpServletRequest request) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //获取当前操作用户的id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //根据用户id获取当前用户基本信息
        UserInfo userInfo = userInfoService.selectOne(new EntityWrapper<UserInfo>().eq("userId", userId));
        //设置投诉人
        doComplaint.setComplainter(userInfo.getUserName());
        // 设置投诉电话号码
        doComplaint.setComplainPhone(userInfo.getPhone());
        //新增投诉信息
        if (doComplaintService.insert(doComplaint)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 根据id删除投诉信息
     *
     * @return
     */
    @RequestMapping("/delComplaintById")
    @ResponseBody
    public Map<String, Object> delComplaintById(Integer doComplaintId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //根据id删除投诉信息
        if (doComplaintService.delete(new EntityWrapper<DoComplaint>().eq("doComplaintId", doComplaintId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 根据id删除投诉信息
     *
     * @return
     */
    @RequestMapping("/delComplaintsByIds")
    @ResponseBody
    public Map<String, Object> delComplaintsByIds(Integer[] doComplaintIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //根据id删除投诉信息
        for (Integer doComplaintId : doComplaintIds) {
            doComplaintService.delete(new EntityWrapper<DoComplaint>().eq("doComplaintId", doComplaintId));
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 接收处理，增加处理人，处理电话
     *
     * @return
     */
    @RequestMapping("/receiveComplaint")
    @ResponseBody
    public Map<String, Object> receiveComplaint(DoComplaint doComplaint, HttpServletRequest request) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //获取当前操作用户的id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //根据用户id获取当前用户基本信息
        UserInfo userInfo = userInfoService.selectOne(new EntityWrapper<UserInfo>().eq("userId", userId));
        //设置处理人名称
        doComplaint.setHandlingPerson(userInfo.getUserName());
        //设置处理人手机号
        doComplaint.setHandlingPhone(userInfo.getPhone());
        //设置处理状态为处理中
        doComplaint.setIsComplete("处理中");
        // 根据id删除投诉信息
        if (doComplaintService.updateById(doComplaint)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 根据投诉对象id获取投诉信息，并跳转到投诉详细信息界面
     *
     * @param doComplaintId
     * @return
     */
    @RequestMapping("/getComplaintInfoToDetail/{doComplaintId}")
    public ModelAndView getComplaintInfoToDetail(@PathVariable(name = "doComplaintId") Integer doComplaintId) {
        ModelAndView modelAndView = new ModelAndView("complaintInfo-detail");
        //获取当前对象的投诉信息
        modelAndView.addObject("complaintInfo", doComplaintService.selectOne(
                new EntityWrapper<DoComplaint>().eq("doComplaintId", doComplaintId)));
        //获取所有投诉类型
        modelAndView.addObject("complaintTypes", complaintService.selectList(null));
        return modelAndView;
    }

    /**
     * 根据投诉对象id获取投诉信息， 跳转投诉编辑界面
     *
     * @return
     */
    @RequestMapping("/complaintInfo-edit/{doComplaintId}")
    public ModelAndView returnJspToComplaintInfoEdit(@PathVariable(name = "doComplaintId") Integer doComplaintId) {
        ModelAndView modelAndView = new ModelAndView("complaintInfo-edit");
        //获取当前对象的投诉信息
        modelAndView.addObject("complaintInfo", doComplaintService.selectOne(
                new EntityWrapper<DoComplaint>().eq("doComplaintId", doComplaintId)));
        //获取所有投诉类型
        modelAndView.addObject("complaintTypes", complaintService.selectList(null));
        return modelAndView;
    }

    /**
     * 编辑投诉信息
     *
     * @param doComplaint
     * @return
     */
    @RequestMapping("/editComplaintInfo")
    @ResponseBody
    public Map<String, Object> editComplaintInfo(DoComplaint doComplaint) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        // 根据id删除投诉信息
        if (doComplaintService.updateById(doComplaint)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 点击进行投诉列表时，跳转到相应界面
     *
     * @return
     */
    @RequestMapping("/doComplaint")
    public ModelAndView returnJspToPeopleComplaintInfo() {
        ModelAndView modelAndView = new ModelAndView("people-complainInfo");
        modelAndView.addObject("complaintTypes", complaintService.selectList(null));
        return modelAndView;
    }

    /**
     * 进行投诉功能中的：获取投诉信息
     *
     * @param page
     * @param limit
     * @param doComplaint
     * @param request
     * @return
     */
    @RequestMapping("/peopleGetComplaintInfo")
    @ResponseBody
    public Map<String, Object> peopleGetComplaintInfo(@RequestParam Integer page,
                                                      @RequestParam Integer limit,
                                                      DoComplaint doComplaint,
                                                      HttpServletRequest request) {
        //获取当前操作用户的id
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        //根据用户id获取当前用户基本信息
        UserInfo userInfo = userInfoService.selectOne(new EntityWrapper<UserInfo>().eq("userId", userId));
        //设置投诉人电话号码
        doComplaint.setComplainPhone(userInfo.getPhone());
        //如果地址不为空
        if (doComplaint.getComplainter() != null && !("").equals(doComplaint.getComplainter())) {
            //设置模糊查询字段
            doComplaint.setComplainter("%" + doComplaint.getComplainter() + "%");
        }
        Map<String, Object> map = new HashMap<String, Object>();
        //根据条件获取投诉信息
        Page<DoComplaint> pages = doComplaintService.selectComplaintInfoByWhere(
                new Page<DoComplaint>(page, limit), doComplaint);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }
}

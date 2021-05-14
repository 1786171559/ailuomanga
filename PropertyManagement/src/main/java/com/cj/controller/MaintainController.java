package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.Maintain;
import com.cj.pojo.Task;
import com.cj.pojo.UserInfo;
import com.cj.service.IMaintainService;
import com.cj.service.ITaskService;
import com.cj.service.IUserInfoService;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/21 20:25
 */
@Controller
@RequestMapping("/maintain")
public class MaintainController {
    @Autowired
    private IMaintainService maintainService;
    @Autowired
    private ITaskService taskService;
    @Autowired
    private IUserInfoService userInfoService;

    /**
     * 点击维修信息列表时,跳转到相应界面
     *
     * @return
     */
    @RequestMapping("/maintain-info")
    public String returnJspToMaintainInfo() {
        return "maintain-info";
    }

    @RequestMapping("/getMainInfo")
    @ResponseBody
    public Map<String, Object> getMainInfo(@RequestParam(defaultValue = "1") Integer page,
                                           @RequestParam(defaultValue = "10") Integer limit,
                                           Maintain maintain,
                                           @RequestParam(defaultValue = "") String taskType) {

        //判断是否进行了精确搜索
        if (!("").equals(taskType) && taskType != null) {
            Task task = taskService.selectOne(new EntityWrapper<Task>().eq("taskType", taskType));
            if (task.getTaskId() != null && !("").equals(task.getTaskId())) {
                System.out.println(task.getTaskId());
                maintain.setTaskId(task.getTaskId());
            }
        }
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Maintain> pages = maintainService.getMainPageByWhere(new Page<Maintain>(page, limit), maintain);
        List<Maintain> maintains = pages.getRecords();
        for (Maintain maintain1 : maintains) {
            System.out.println(maintain1);
        }
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 删除单个维修信息
     *
     * @param maintainId
     * @return
     */
    @RequestMapping("/delMaintainBymaintainId")
    @ResponseBody
    public Map<String, Object> delMaintainBymaintainId(Integer maintainId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (maintainService.delete(new EntityWrapper<Maintain>().eq("maintainId", maintainId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 删除多个维修信息
     *
     * @param maintainIds
     * @return
     */
    @RequestMapping("/delMaintainsBymaintainIds")
    @ResponseBody
    public Map<String, Object> delMaintainsBymaintainIds(Integer[] maintainIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        for (Integer maintainId : maintainIds) {
            maintainService.delete(new EntityWrapper<Maintain>().eq("maintainId", maintainId));
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 当点击编辑维修按钮时,获取当前行对象信息,并跳转到编辑界面
     *
     * @param maintainId
     */
    @RequestMapping("/getOneMaintainById/{maintainId}")
    public ModelAndView getOneMaintainById(@PathVariable(name = "maintainId") Integer maintainId) {
        //创建modelAndView对象
        ModelAndView modelAndView = new ModelAndView("maintain-edit");
        //获取当前对象的信息并存入request域中
        modelAndView.addObject("maintain", maintainService.selectOneMaintainByMaintainId(maintainId));
        modelAndView.addObject("task", taskService.selectList(null));
        return modelAndView;
    }

    /**
     * 修改维修信息
     *
     * @param maintain
     * @return
     */
    @RequestMapping("/changeMaintain")
    @ResponseBody
    public Map<String, Object> changeMaintain(Maintain maintain) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (maintainService.updateById(maintain)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 新增按钮点击时,获取任务表信息,并跳转到新增维修界面
     *
     * @return
     */
    @RequestMapping("/maintain-add")
    public ModelAndView returnJspToMaintainAdd() {
        ModelAndView modelAndView = new ModelAndView("maintain-add");
        //获取任务表信息,并存储到request域中
        modelAndView.addObject("task", taskService.selectList(null));
        return modelAndView;
    }

    /**
     * 新增维修信息
     *
     * @param maintain
     * @return
     */
    @RequestMapping("/addMaintain")
    @ResponseBody
    public Map<String, Object> addMaintain(Maintain maintain) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (maintainService.insert(maintain)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 当派遣按钮点击时,
     * 获取所有户主信息和当前行点击对象的维修id,
     * 并跳转到派遣界面
     *
     * @return
     */
    @RequestMapping("/returnJspToDisPatchPerson/{maintainId}")
    public ModelAndView returnJspToDisPatchPerson(@PathVariable(name = "maintainId") Integer maintainId) {
        ModelAndView modelAndView = new ModelAndView("dispatch-person");
        //把维修id添加到request域中
        modelAndView.addObject("maintainId", maintainId);
        //把维修人员信息添加到request域中
        modelAndView.addObject("userInfo", userInfoService.getUserInfoByRoleName("维修人员"));
        return modelAndView;
    }

    /**
     * 派遣维修人员,更新维修表字段repairId
     *
     * @return
     */
    @RequestMapping("/dispatchPerson")
    @ResponseBody
    public Map<String, Object> dispatchPerson(Integer maintainId, Integer repairId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //创建维修类对象
        Maintain maintain = new Maintain();
        //给对象属性赋值
        maintain.setMaintainId(maintainId);
        maintain.setRepairId(repairId);
        //更新派遣时间
        maintain.setProcessingTime(new Timestamp(new Date().getTime()));
        if (maintainService.updateById(maintain)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 获取维修详细信息
     * 跳转到维修信息详情
     *
     * @param maintainId
     * @return
     */
    @RequestMapping("/getMainToDetail/{maintainId}")
    public ModelAndView getMainToDetail(@PathVariable(name = "maintainId") Integer maintainId) {
        ModelAndView modelAndView = new ModelAndView("maintain-detail");
        //获取当前对象的信息并存入request域中
        Maintain maintain = maintainService.selectOneMaintainByMaintainId(maintainId);
        modelAndView.addObject("maintain", maintain);
        //获取当前点击对象的报修人员信息并存入request域中
        modelAndView.addObject("userInfo",
                userInfoService.selectOne(new EntityWrapper<UserInfo>().
                        eq("userId", maintain.getUserId())));
        //判断是否派遣维修人员,如果派遣了,则在request域中存入派遣人员信息.否则则存入null
        if (maintain.getRepairId() != null) {
            modelAndView.addObject("repairInfo",
                    userInfoService.selectOne(new EntityWrapper<UserInfo>().
                            eq("userId", maintain.getRepairId())));
        } else {
            modelAndView.addObject("repairInfo", "null");
        }
        return modelAndView;
    }

    /**
     * 获取当前维修信息的评价信息，并跳转到评分界面
     *
     * @param maintainId
     * @return
     */
    @RequestMapping("/doScore/{maintainId}")
    public ModelAndView returnJspToDoScore(@PathVariable(name = "maintainId") Integer maintainId) {
        ModelAndView modelAndView = new ModelAndView("doScore");
        //获取当前对象的维修信息
        Maintain maintain = maintainService.selectOne(new EntityWrapper<Maintain>().eq("maintainId", maintainId));
        //把评分存储到request域中
        modelAndView.addObject("score", maintain.getScore());
        modelAndView.addObject("maintainId", maintain.getMaintainId());
        return modelAndView;
    }

    /**
     * 维修评分，更新维修信息
     * @return
     */
    @RequestMapping("/doScoreSubmit")
    @ResponseBody
    public  Map<String,Object> doScoreSubmit(Maintain maintain){
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (maintainService.updateById(maintain)){
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }
}

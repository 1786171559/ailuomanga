package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.Maintain;
import com.cj.pojo.Notice;
import com.cj.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/22 18:16
 */
@Controller
@RequestMapping("notice")
public class NoticeController {
    @Autowired
    private INoticeService noticeService;

    /**
     * 点击公告列表时,跳转公告信息界面
     *
     * @return
     */
    @RequestMapping("notice-info")
    public ModelAndView returnJspToNoticeInfo() {
        ModelAndView modelAndView = new ModelAndView("notice-info");
        //modelAndView.addObject("noticeInfo", noticeService.selectPage(new Page<Notice>(1, 7)).getRecords());
        return modelAndView;
    }

    /**
     * layui流加载公告信息
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/getNoticeInfo")
    @ResponseBody
    public Map<String, Object> getNoticeInfo(Integer page, Integer limit) {
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Notice> pages = noticeService.selectNoticeOrderByPublishDate(new Page<Notice>(page, limit));
        map.put("data", pages.getRecords());
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("msg", "");
        return map;
    }
    /**
     * layui流加载公告信息
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/personGetNoticeInfo")
    @ResponseBody
    public Map<String, Object>   personGetNoticeInfo(Integer page, Integer limit){
        Map<String, Object> map = new HashMap<String, Object>();
        Page<Notice> pages = noticeService.selectNoticeOrderByPublishDate(new Page<Notice>(page, limit));
        map.put("data", pages.getRecords());
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("msg", "");
        return map;
    }
    /**
     * 删除通知
     *
     * @param noticeId
     * @return
     */
    @RequestMapping("/delNoticeByNoticeId")
    @ResponseBody
    public Map<String, Object> delNoticeByNoticeId(Integer noticeId) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (noticeService.delete(new EntityWrapper<Notice>().eq("noticeId", noticeId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 点击公告发布列表时,跳转到相应界面
     *
     * @return
     */
    @RequestMapping("/notice-add")
    public String returnJspToNoticePublish() {
        return "notice-publish";
    }

    /**
     * 新增通知
     * @param notice
     * @return
     */
    @RequestMapping("/addNotice")
    @ResponseBody
    public Map<String, Object> addNotice(Notice notice) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (noticeService.insert(notice)){
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }


}

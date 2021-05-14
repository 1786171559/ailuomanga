package com.cj.controller;

import com.cj.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/25 9:05
 */
@RequestMapping("/ImportantNotice")
@Controller
public class PesonNoticeComtroller {
    @Autowired
    private INoticeService noticeService;

    /**
     * 跳转到通知界面
     *
     * @return
     */
    @RequestMapping("/showNotice")
    public String returnJspToNotcieInfo() {
        return "person-notice";
    }
}

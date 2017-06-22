package com.aibasis.mvc.controller;

import com.aibasis.http.HttpTookit;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by llc on 17/2/23.
 */
@Controller
@RequestMapping("/opensdk")
public class sdkController {
    @RequestMapping("/log")
    public String index() {
        return "log";
    }

    @RequestMapping("/realtime-memberId")
    @ResponseBody
    public String getRealTimeLog(@RequestParam("date") String date,
                                 @RequestParam(value = "memberId") String memberId,
                                 @RequestParam(value = "level", defaultValue = "all") String level,
                                 @RequestParam(value = "env", defaultValue = "all") String env,
                                 @RequestParam(value = "source", defaultValue = "xiaole") String src) {
        HttpTookit http = new HttpTookit();
        String url = "http://stat.hixiaole.com:8081/log/search/realtime-memberId?date=" + date
                + "&memberId=" + memberId + "&level=" + level
                + "&env=" + env + "&source=" + src;
        try{
            String str = http.sendGet(url);
            if (str != "") {
                String s = str.substring(1, str.length() - 1);
                ModelAndView mv = new ModelAndView();
                mv.addObject("logList", s);
                return s;
            } else {
                return "查询出错了, 请检查日期, memberId等信息";
            }

        }catch (Exception e) {
            e.printStackTrace();
            return "查询出错了, 请检查日期, memberId等信息";
        }
    }

    @RequestMapping("/realtime-deviceId")
    @ResponseBody
    public String getRealTimeLogByDeviceId(@RequestParam("date") String date,
                                 @RequestParam(value = "deviceId") String deviceId,
                                 @RequestParam(value = "level", defaultValue = "all") String level,
                                 @RequestParam(value = "env", defaultValue = "all") String env,
                                 @RequestParam(value = "source", defaultValue = "xiaole") String src) {
        HttpTookit http = new HttpTookit();
        String url = "http://stat.hixiaole.com:8081/log/search/realtime-deviceId?date=" + date
                + "&deviceId=" + deviceId + "&level=" + level
                + "&env=" + env + "&source=" + src;
        try{
            String str = http.sendGet(url);
            if (str != "") {
                String s = str.substring(1, str.length() - 1);
                ModelAndView mv = new ModelAndView();
                mv.addObject("logList", s);
                return s;
            } else {
                return "查询出错了, 请检查日期, deviceId等信息";
            }

        }catch (Exception e) {
            e.printStackTrace();
            return "查询出错了, 请检查日期, deviceId等信息";
        }
    }
}

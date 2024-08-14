package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // 使當前的 session 失效
        request.getSession().invalidate();
        // 重定向到登出後的頁面
        return "redirect:/index";
    }
}
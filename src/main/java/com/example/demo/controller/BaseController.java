package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class BaseController {

    @GetMapping("/index")
    public String index() {
        return "th/index_bb"; // 返回 Thymeleaf 视图，明确前缀为 th/
    }
    
    @GetMapping("/about")
    public String about() {
        return "th/about"; // 返回 Thymeleaf 视图，明确前缀为 th/
    }
}

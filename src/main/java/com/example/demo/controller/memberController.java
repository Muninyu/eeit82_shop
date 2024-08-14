package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.demo.DailyCalories;
import com.example.demo.Meal;
import com.example.demo.service.EatFoodCaloriesService;
import com.fasterxml.jackson.databind.ObjectMapper;



@Controller
public class memberController {
	
	private static final Logger logger = LoggerFactory.getLogger(EatFoodCaloriesController.class);

    @Autowired
    private EatFoodCaloriesService efService;

    @Autowired
    private ObjectMapper objectMapper;
	
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        Integer totalCalories = efService.getTotalCalories(session);
        model.addAttribute("totalCalories", totalCalories != null ? totalCalories : 0);

        // 序列化 dailyCalories 数据
        List<DailyCalories> dailyCalories = efService.getDailyCalories(session);
        
        int daysToShow = 7;
        if (dailyCalories.size() > daysToShow) {
            dailyCalories = dailyCalories.subList(dailyCalories.size() - daysToShow, dailyCalories.size());
        }
        try {
            String dailyCaloriesJson = objectMapper.writeValueAsString(dailyCalories);
            model.addAttribute("dailyCaloriesJson", dailyCaloriesJson);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error serializing dailyCalories", e);
        }

        // 获取当前登录用户的用餐记录
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            List<Meal> userMeals = efService.getMealsByUserEmail(email);
            model.addAttribute("userMeals", userMeals);
        } else {
            model.addAttribute("userMeals", null);
            return "redirect:/api/caloriesPage";
        }

        return "dashboard"; // 返回 JSP 视图，没有前缀
    }
    
	@GetMapping("/ques1")
    public String ques() {
        return "question1";
    }
	@GetMapping("/test2")
    public String test() {
        return "login";
    }
	
	@GetMapping("/test3")
    public String test1() {
        return "login2";
    }

	
	@RequestMapping(value = "/views/**", method = RequestMethod.GET)
    public String showView(HttpServletRequest request) {
        // 获取请求的URI，并移除前缀
        String uri = request.getRequestURI();
        String viewName = uri.substring(uri.lastIndexOf("/views/") + 7);
        // 返回视图名
        return viewName;
}
}
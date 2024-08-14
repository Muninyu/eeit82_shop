package com.example.demo.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.DailyCalories;
import com.example.demo.Meal;
import com.example.demo.service.EatFoodCaloriesService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/eat")
public class EatFoodCaloriesController {

    private static final Logger logger = LoggerFactory.getLogger(EatFoodCaloriesController.class);

    @Autowired
    private EatFoodCaloriesService efService;

    @Autowired
    private ObjectMapper objectMapper;

    @GetMapping("/eatcalories")
    public String eatCalories(Model model, HttpSession session) {
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

        return "EatCalories"; // 返回 JSP 视图，没有前缀
    }

    @PostMapping("/submit_form")
    public String submitForm(@RequestParam("meal") int mealCalories, @RequestParam("mealName") String mealName, HttpSession session, Model model) {
        try {
            efService.saveMeal(mealCalories, mealName, session);
            model.addAttribute("message", "Meal submitted successfully!");
            return "redirect:/eat/eatcalories";
        } catch (Exception e) {
            logger.error("Error submitting form", e);
            return "error";
        }
    }

    // 新增获取用户用餐记录的端点
    @GetMapping("/user_meals")
    @ResponseBody
    public List<Meal> getUserMeals(@RequestParam("date") String date, HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            LocalDate localDate = LocalDate.parse(date);
            return efService.getMealsByUserEmailAndDate(email, localDate);
        } else {
            return null;
        }
    }
    
    
    @DeleteMapping("/delete_meal")
    @ResponseBody
    public String deleteMeal(@RequestParam("mealId") Long mealId, HttpSession session) {
        try {
            efService.deleteMeal(mealId, session);
            return "Meal deleted successfully";
        } catch (Exception e) {
            logger.error("Error deleting meal", e);
            return "Error deleting meal";
        }
        
        
    }
    
   
}

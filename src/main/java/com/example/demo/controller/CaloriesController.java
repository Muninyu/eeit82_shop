package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import com.example.demo.SportCalories;
import com.example.demo.service.FitnessGoalService;
import com.example.demo.service.SportCaloriesService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/api")
public class CaloriesController {

    private static final Logger logger = LoggerFactory.getLogger(CaloriesController.class);

    @Autowired
    private SportCaloriesService sportCaloriesService;
    
    @Autowired
    private FitnessGoalService fitnessGoalService;

    @PostMapping("/saveSportCalories")
    public String saveSportCalories(@RequestParam("calories") double calories, @RequestParam("date") String date, HttpSession session) {
        try {
            LocalDate localDate = LocalDate.parse(date);
            sportCaloriesService.saveSportCalories(calories, localDate, session);
            return "redirect:/api/caloriesPage";
        } catch (Exception e) {
            logger.error("Error saving sport calories", e);
            return "error";
        }
    }

    @GetMapping("/caloriesPage")
    public String getCaloriesPage(HttpSession session, Model model) {
        String email = (String) session.getAttribute("logInEmail");
        if (email == null) {
            return "redirect:/test2"; // 如果用户未登录，重定向到登录页面
        }
        Double totalC = sportCaloriesService.getTotalCalories(session);
        model.addAttribute("totalC", totalC != null ? totalC : 0);
        return "GymTrain"; // 确保返回值与 JSP 文件名一致
    }

    @GetMapping("/user_sport_calories")
    @ResponseBody
    public List<SportCalories> getUserSportCalories(@RequestParam("date") String date, HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email == null) {
            throw new RuntimeException("User not logged in");
        }
        LocalDate localDate = LocalDate.parse(date);
        return sportCaloriesService.getSportCaloriesByUserEmailAndDate(email, localDate);
    }
    
    @GetMapping("/userWeight")
    public ResponseEntity<BigDecimal> getUserWeight(HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            BigDecimal weight = fitnessGoalService.getUsersWeight(session);
            return ResponseEntity.ok(weight);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}

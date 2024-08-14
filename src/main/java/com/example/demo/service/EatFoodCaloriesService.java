package com.example.demo.service;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.DailyCalories;
import com.example.demo.Meal;
import com.example.demo.Users;
import com.example.demo.repository.EatRepository;
import com.example.demo.repository.UsersDao;

@Service
public class EatFoodCaloriesService {

    private final EatRepository eatRepository;
    private final UsersDao usersDao;

    @Autowired
    public EatFoodCaloriesService(EatRepository eatRepository, UsersDao usersDao) {
        this.eatRepository = eatRepository;
        this.usersDao = usersDao;
    }

    public void saveMeal(int mealCalories, String mealName, HttpSession session) {
        Meal meal = new Meal();
        meal.setMeal_name(mealName);
        meal.setCalories(mealCalories);
        meal.setDate(LocalDate.now());

        // 从会话中获取用户电子邮件
        String email = (String) session.getAttribute("logInEmail");

        if (email != null) {
            Users users = usersDao.findByEmail(email);
            if (users != null) {
                meal.setUsers(users);
                eatRepository.save(meal);
            } else {
                throw new RuntimeException("User not found: " + email);
            }
        } else {
            throw new RuntimeException("User email not found in session");
        }
    }

    public Integer getTotalCalories(HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            Users user = usersDao.findByEmail(email);
            return eatRepository.getTotalCaloriesByUser(user);
        } else {
            return 0;
        }
    }

    public List<DailyCalories> getDailyCalories(HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            Users user = usersDao.findByEmail(email);
            return eatRepository.findDailyCaloriesByUser(user);
        } else {
            return List.of();
        }
    }

    public List<Meal> getMealsByUserEmail(String email) {
        Users users = usersDao.findByEmail(email);
        return users != null ? eatRepository.findByUsers(users) : null;
    }
    
    public List<Meal> getMealsByUserEmailAndDate(String email, LocalDate date) {
        Users user = usersDao.findByEmail(email);
        return user != null ? eatRepository.findByUsersAndDate(user, date) : null;
    }
    
    public void deleteMeal(Long mealId, HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");

        if (email != null) {
            Users user = usersDao.findByEmail(email);
            if (user != null) {
                eatRepository.deleteByIdAndUsers(mealId, user);
            } else {
                throw new RuntimeException("User not found: " + email);
            }
        } else {
            throw new RuntimeException("User email not found in session");
        }
    }
    
}

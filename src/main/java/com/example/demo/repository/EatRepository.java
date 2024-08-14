package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.DailyCalories;
import com.example.demo.Meal;
import com.example.demo.Users;

@Repository
public interface EatRepository extends JpaRepository<Meal, Long> {

    @Query("SELECT SUM(m.meal_calories) FROM Meal m WHERE m.users = :user")
    Integer getTotalCaloriesByUser(Users user);

    @Query("SELECT new com.example.demo.DailyCalories(m.meal_date, SUM(m.meal_calories)) " +
           "FROM Meal m WHERE m.users = :user GROUP BY m.meal_date ORDER BY m.meal_date")
    List<DailyCalories> findDailyCaloriesByUser(Users user);

    List<Meal> findByUsers(Users users);
    
    @Query("SELECT m FROM Meal m WHERE m.users = :user AND m.meal_date = :date")
    List<Meal> findByUsersAndDate(Users user, LocalDate date);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM Meal m WHERE m.meal_id = :id AND m.users = :user")
    void deleteByIdAndUsers(Long id, Users user);
}

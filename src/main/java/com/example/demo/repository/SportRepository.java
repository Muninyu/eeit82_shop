package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.SportCalories;
import com.example.demo.Users;

@Repository
public interface SportRepository extends JpaRepository<SportCalories, Long> {

    @Query("SELECT SUM(s.sportCalories) FROM SportCalories s WHERE s.users = :user")
    Double getTotalCaloriesByUser(Users user);

    List<SportCalories> findByUsersAndSportDate(Users user, LocalDate date);
}

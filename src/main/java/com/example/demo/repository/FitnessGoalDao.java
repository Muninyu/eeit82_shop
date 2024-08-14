package com.example.demo.repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.FitnessGoal;

import com.example.demo.Users;

@Repository
public interface FitnessGoalDao extends JpaRepository<FitnessGoal, Integer> {
    
    FitnessGoal findByUsers(Users users);
    
    @Query(value = "SELECT f FROM FitnessGoals f WHERE f.user = :user ORDER BY f.updateAt DESC", nativeQuery = true)
    Optional<FitnessGoal> findLatestByUsers(@Param("user") Users users);
    
    @Query(value = "SELECT f.* FROM Fitness_Goals f JOIN Users u ON f.user_id = u.user_id WHERE u.email = :email ORDER BY f.updated_at DESC LIMIT 1", nativeQuery = true)
    Optional<FitnessGoal> findTopByUsersEmailOrderByUpdateAtDescNative(@Param("email") String email);
    
    @Query(value = "SELECT f.current_weight FROM Fitness_Goals f JOIN Users u ON f.user_id = u.user_id WHERE u.email = :email", nativeQuery = true)
    List<BigDecimal> findCurrentWeightsByUserEmail(@Param("email") String email);
    
    @Query(value = "SELECT f.current_weight FROM Fitness_Goals f JOIN Users u ON f.user_id = u.user_id WHERE u.email = :email ORDER BY f.updated_at DESC LIMIT 1", nativeQuery = true)
    BigDecimal findLatestWeightByUserEmail(@Param("email") String email);
}
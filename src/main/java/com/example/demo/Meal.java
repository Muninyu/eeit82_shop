package com.example.demo;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "meal_calories")
public class Meal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long meal_id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private Users users;
    
    @Column(name = "meal_name")
    private String meal_name;

    @Column(name = "meal_calories")
    private int meal_calories;

    @Column(name = "meal_date")
    private LocalDate meal_date;

    // Getters 和 setters
    public Long getId() {
        return meal_id;
    }

    public void setId(Long meal_id) {
        this.meal_id = meal_id;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public String getMeal_name() {
        return meal_name;
    }

    public void setMeal_name(String meal_name) {
        this.meal_name = meal_name;
    }

    public int getCalories() {
        return meal_calories;
    }

    public void setCalories(int meal_calories) {
        this.meal_calories = meal_calories;
    }

    public LocalDate getDate() {
        return meal_date;
    }

    public void setDate(LocalDate meal_date) {
        this.meal_date = meal_date;
    }
}

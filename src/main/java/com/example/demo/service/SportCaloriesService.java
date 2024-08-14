package com.example.demo.service;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.SportCalories;
import com.example.demo.Users;
import com.example.demo.repository.SportRepository;
import com.example.demo.repository.UsersDao;

@Service
public class SportCaloriesService {

    @Autowired
    private SportRepository sportRepository;

    @Autowired
    private UsersDao usersDao;

    public void saveSportCalories(double calories, LocalDate date, HttpSession session) {
        SportCalories sportCalories = new SportCalories();
        sportCalories.setSportCalories(calories);
        sportCalories.setSportDate(date);
        String email = (String) session.getAttribute("logInEmail");

        if (email != null) {
            Users users = usersDao.findByEmail(email);
            if (users != null) {
                sportCalories.setUsers(users);
                sportRepository.save(sportCalories);
            } else {
                throw new RuntimeException("User not found: " + email);
            }
        } else {
            throw new RuntimeException("User email not found in session");
        }
    }

    public Double getTotalCalories(HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            Users user = usersDao.findByEmail(email);
            return sportRepository.getTotalCaloriesByUser(user);
        } else {
            return 0.0;
        }
    }

    public List<SportCalories> getSportCaloriesByUserEmailAndDate(String email, LocalDate date) {
        Users user = usersDao.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("User not found with email: " + email);
        }
        return sportRepository.findByUsersAndSportDate(user, date);
    }
}

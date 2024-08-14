package com.example.demo.service;

import org.hibernate.Hibernate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.FitnessGoal;
import com.example.demo.Users;
import com.example.demo.repository.FitnessGoalDao;
import com.example.demo.repository.UsersDao;


@Service
public class FitnessGoalService {
	
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private FitnessGoalDao fitnessGoalDao;
	
	//part1,4,5用到
	//保存及關連Users
	public Users saveUser(Users users) {
		return usersDao.save(users);
	}
	//part2用到
	//保存及關連Users FitnessGoal
	public void saveUserAndFit(Users users, FitnessGoal fitnessGoal) {
    	users = usersDao.save(users);
    	users.addFitnessGoal(fitnessGoal);
    	fitnessGoalDao.save(fitnessGoal);
    }
	//part3用到
	public FitnessGoal saveFitnessGoal(FitnessGoal fitnessGoal) {
		return fitnessGoalDao.save(fitnessGoal);
    }
	
	
	//用戶體重
	public BigDecimal getUsersWeight(HttpSession session) {
        String email = (String) session.getAttribute("logInEmail");
        if (email != null) {
            BigDecimal weight = fitnessGoalDao.findLatestWeightByUserEmail(email);
            if (weight != null) {
                return weight;
            } else {
                return BigDecimal.ZERO; // 當找不到體重時返回 BigDecimal.ZERO
            }
        } else {
            return BigDecimal.ZERO; // 當 email 為空時也返回 BigDecimal.ZERO
        }
    }
	
//	public FitnessGoal getFitnessGoalWithUser(int goalId) {
//	    FitnessGoal fitnessGoal = fitnessGoalDao.findById(goalId).orElse(null);
//	    if (fitnessGoal != null) {
//	        Hibernate.initialize(fitnessGoal.getUsers());
//	    }
//	    return fitnessGoal;
//	}
	
	
	//index.jsp用到
	//更新會員體重資料  currentweight
//	public boolean updateUser1 (FitnessGoal fitnessGoal) {
//		Users users = fitnessGoal.getUsers();
//		
//		Optional<FitnessGoal> existingFitOpt = fitnessGoalDao.findLatestByUsers(users);
//		
//		if(existingFitOpt.isPresent()) {
//			FitnessGoal exFitnessGoal = existingFitOpt.get();
//			
//			exFitnessGoal.setCurrent_weight(fitnessGoal.getCurrent_weight());
//			
//			fitnessGoalDao.save(exFitnessGoal);
//			return true;
//		}else {
//			return false;
//		}
//	}
	
	
}



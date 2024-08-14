package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Users;
import com.example.demo.repository.UserDao;


@Service
public class UserService {

	 @Autowired
	    private UserDao userDao;

	    public Users findByEmail(String email) {
	        return userDao.findByEmail(email);
	    }

		 
}

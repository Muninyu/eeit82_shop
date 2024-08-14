package com.example.demo.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.sql.Result;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.Checkinlogs;
import com.example.demo.FitnessGoal;

import com.example.demo.Users;
import com.example.demo.repository.FitnessGoalDao;
import com.example.demo.repository.UsersDao;
import com.example.demo.service.CheckinlogsService;
import com.example.demo.service.FitnessGoalService;

import com.example.demo.service.UsersService;

import dto.BCrypt;
import dto.IndexInput;
import dto.InputData;
import dto.PasswordChangeRequest;
import dto.WeightChart;





@RestController
@RequestMapping
public class memberRestController {
	
	
	
//	saveSurveyAndUser(survey, user);
	@Autowired
	private FitnessGoalDao fitnessGoalDao;
	@Autowired
	private UsersDao usersDao;
	
	
	@Autowired
	private  UsersService usersService;
	@Autowired
	private  FitnessGoalService fitnessGoalService;
	
	@Autowired
    private CheckinlogsService checkinlogsService;

    public memberRestController(UsersService usersService, FitnessGoalService fitnessGoalService) {
        this.usersService = usersService;
        this.fitnessGoalService = fitnessGoalService;
    }
    //index.jsp用到
    	//==============會員資料更新 start===============================  
	    @PostMapping("/updateUser")
	    public ResponseEntity<Map<String, Object>> updateUser(@RequestBody InputData inputData) {
	        
	    	// 添加日志记录，检查接收到的数据
	        System.out.println("Received user data: " + inputData);
	        boolean isUpdated = usersService.updateUser(inputData);
	        Map<String, Object> response = new HashMap<>();
	        if (isUpdated) {
	            response.put("success", true);
	            response.put("message", "資料已更新");
	            System.out.println("Update success: " + response); // 打印響應
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("success", false);
	            response.put("message", "更新失敗");
	            System.out.println("Update failed: " + response); // 打印響應
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    }
	  //會員資料_體重更新_fk  currentweight    
	    @PostMapping("/updateWeight")
	    public FitnessGoal updateWeight(@RequestBody FitnessGoal fitnessGoal) {
	        FitnessGoal updatedGoal = fitnessGoalService.saveFitnessGoal(fitnessGoal);
	        Hibernate.initialize(updatedGoal.getUsers());
	        return updatedGoal;
	    }
	    
//	
	   //會員資料_更改密碼
	    @PostMapping("/changePassword")
	    public ResponseEntity<Map<String, Object>> changePassword(@RequestBody PasswordChangeRequest passwordChangeRequest) {
	        boolean isPasswordChanged = usersService.changePassword(passwordChangeRequest);
	        Map<String, Object> response = new HashMap<>();
	        if (isPasswordChanged) {
	            response.put("success", true);
	            response.put("message", "密碼已更改");
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("success", false);
	            response.put("message", "密碼更改失敗");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	        }
	    }
	  //==============會員資料更新 end=============================== 
	    
	  //login.jsp用的  
	  //==============會員登入 start=============================== 
	    @PostMapping("/login")
	    public ResponseEntity<Map<String, Object>> login(@RequestBody Users loginUser, HttpSession session) {
	        Users users = usersService.getUserByEmail(loginUser.getEmail());
	        
	        Map<String, Object> response = new HashMap<>();
	        if (users != null && BCrypt.checkpw(loginUser.getPassword(), users.getPassword())) {
	            // 設置緩存
	            session.setAttribute("logInEmail", users.getEmail());
	            session.setAttribute("loginId", users.getUser_id());
	            System.out.println("Session loginId set to: " + users.getUser_id());
	            // 返回成功消息和用戶信息
	            response.put("success", true);
	            response.put("message", "登入成功");
	            response.put("user", users); // 包含完整用戶信息
	            response.put("loginId", users.getUser_id());
	            System.out.println("Login successful for email: " + users.getEmail());
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("success", false);
	            response.put("message", "電子郵件或密碼錯誤");
	            System.out.println("Login failed for email: " + loginUser.getEmail());
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
	        }
	    }
	    
	  
	  //==============會員登入 end=============================== 
	    
	    //question1 - question4
//	    =======問卷入資料庫start=============
	    @PostMapping
	    public FitnessGoal addWeightRecord(@RequestBody FitnessGoal fitnessGoal) {
	        // 不要設置 ts，讓它由 @PrePersist 方法自動生成
	        return fitnessGoalDao.save(fitnessGoal);
	    }

	    @GetMapping
	    public List<FitnessGoal> getAllWeightRecords() {
	        return fitnessGoalDao.findAll();
	    }
	    @PostMapping("/part1")
	    public Users handlePart1(@RequestBody InputData inputData, HttpSession session) {
	        Users users = (Users) session.getAttribute("response1");
	        
	        if (users == null) {
	        	users = new Users();
	        }
	        

	        users.setGender(inputData.getGender());
	        users.setBirthday(inputData.getBirthday());
	        users.setHeight_cm(inputData.getHeight_cm());
	               
	        users = fitnessGoalService.saveUser(users);
	       
	        session.setAttribute("response1", users);
	        
	        System.out.println(users);
	        return users;
	    }
	    
	    @PostMapping("/part2")
	    public FitnessGoal handlePart2(@RequestBody InputData inputData, HttpSession session) {
	        FitnessGoal fitnessGoal = (FitnessGoal) session.getAttribute("response");
	        Users users = (Users) session.getAttribute("response1");
	        if (fitnessGoal == null) {
	        	fitnessGoal = new FitnessGoal();
	        }
	        if (users == null) {
	            users = new Users();
	        }

	        users.setPurpose(inputData.getPurpose());
	        fitnessGoal.setCurrent_weight(inputData.getCurrent_weight());
	        users.setTarget_weight(inputData.getTarget_weight());
	        
	        
	        // 同時保存 User 和 Survey
	        fitnessGoalService.saveUserAndFit(users, fitnessGoal);

	        session.setAttribute("response", fitnessGoal);
	        session.setAttribute("response1", users);
	        
	        System.out.println(users);
	        System.out.println(fitnessGoal);
	        return fitnessGoal;
	        
	    }
	    
	    @PostMapping("/part3")
	    public FitnessGoal handlePart3(@RequestBody InputData inputData, HttpSession session) {
	    	FitnessGoal fitnessGoal = (FitnessGoal) session.getAttribute("response");
	        
	        if (fitnessGoal == null) {
	        	fitnessGoal = new FitnessGoal();
	        }
	        
	        fitnessGoal.setUpdate_at(inputData.getUpdate_at());
       
	        fitnessGoal = fitnessGoalService.saveFitnessGoal(fitnessGoal);
	        		
	        session.setAttribute("response", fitnessGoal);
	        
	        
	        System.out.println(fitnessGoal);
	        return fitnessGoal;
	    }
	    
	    @PostMapping("/part4")
	    public Users handlePart4(@RequestBody InputData inputData, HttpSession session) {
	       
	        Users users = (Users) session.getAttribute("response1");
	        if (users == null) {
	        	users = new Users();
	        }
	        users.setActivity_level(inputData.getActivity_level());
	       
	        users = fitnessGoalService.saveUser(users);
	        
	        session.setAttribute("response1", users);
	        System.out.println(users);
	        
	        return users;
	    }
	    
	    @PostMapping("/part5")
	    public ResponseEntity<?> handlePart5(@RequestBody InputData inputData, HttpSession session) {
	    	Users users = (Users) session.getAttribute("response1");
	    	try {
	            if (usersService.isAccountExist(inputData.getEmail())) {
	                return ResponseEntity.status(HttpStatus.CONFLICT).body("Email already in use");//如果email已經存在就擋住
	            } else {
	            	
	            	users.setEmail(inputData.getEmail());
	                users.setPassword(BCrypt.hashpw(inputData.getPassword(), BCrypt.gensalt()));
	                users.setReal_name(inputData.getReal_name());
	                users = fitnessGoalService.saveUser(users);
	                session.removeAttribute("response1");
	                session.removeAttribute("response");
	                return ResponseEntity.ok(users);
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Internal Server Error");
	        }
	    }

//	    =======問卷入資料庫end=============
	    
	  //bodyreport.jsp用到  
//      =======bodyreport抓資料start===================
	    //最新一筆資料
	    @GetMapping("/user/{email}")
	    public ResponseEntity<IndexInput> getUserWeight(@PathVariable String email) {
	    	Optional<IndexInput> indexInput = usersService.getUserWeight(email);
	    	return indexInput.map(ResponseEntity::ok)
	                .orElseGet(() -> ResponseEntity.notFound().build());
	    }
	  //該ID 所有currentweight資料
	    @GetMapping("/user/weight-chart/{email}")
	    public ResponseEntity<WeightChart> getWeightChart(@PathVariable String email) {
	    	Optional<WeightChart> weightChart = usersService.getWeightChart(email);
	    	return weightChart.map(ResponseEntity::ok)
	                .orElseGet(() -> ResponseEntity.notFound().build());
	    }
//      =======bodyreport抓資料end===================
	    
	    //dashboard.jsp
//		============簽到日歷 start=============
	    //依據ID 來建立簽到時間
 	    @PostMapping("/add")
	    public Checkinlogs addCheckinLog(@RequestParam int userId) {
	    	Users users = usersService.getUserById(userId); // 確保你有這個方法來獲取User對象
	        Checkinlogs checkinlog = new Checkinlogs();
	        checkinlog.setUsers(users);
	        checkinlog.setCheckin_date(new Date());
	        return checkinlogsService.addCheckinlogs(checkinlog);
	    }
 	    //抓該ID 所有簽到時間
	    @GetMapping("/check/{userId}")
	    public List<Checkinlogs> getCheckinLogsByUserId(@PathVariable int userId) {
	        return checkinlogsService.getCheckinLogsByUserId(userId);
	    }
	    
	    @GetMapping("/checkCheckinStatus")
	    public ResponseEntity<Map<String, Boolean>> checkCheckinStatus(@RequestParam int userId) {
	        boolean hasCheckedInToday = checkinlogsService.hasCheckedInToday(userId);
	        Map<String, Boolean> response = new HashMap<>();
	        response.put("hasCheckedInToday", hasCheckedInToday);
	        return ResponseEntity.ok(response);
	    }

	  //============簽到日歷 end=============
	}



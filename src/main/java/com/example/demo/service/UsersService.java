package com.example.demo.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.FitnessGoal;
import com.example.demo.Users;
import com.example.demo.repository.FitnessGoalDao;
import com.example.demo.repository.UsersDao;

import dto.BCrypt;
import dto.IndexInput;
import dto.InputData;
import dto.PasswordChangeRequest;
import dto.WeightChart;


@Service
public class UsersService {
	
	@Autowired
	private UsersDao usersDao;
	@Autowired
	private FitnessGoalDao fitnessGoalDao;
	


// index.jsp用到的
//	==========會員更新判斷 start==========
	public boolean updateUser(InputData inputData) {
		Users existingUsers = usersDao.findByEmail(inputData.getEmail());
			//更新會員資料
		if(existingUsers != null) {
			existingUsers.setNickname(inputData.getNickname());
            existingUsers.setGender(inputData.getGender());
            existingUsers.setBirthday(inputData.getBirthday());
            existingUsers.setPhone(inputData.getPhone());
            existingUsers.setHeight_cm(inputData.getHeight_cm());
            existingUsers.setFace(inputData.getFace());
            usersDao.save(existingUsers);
            
            //找對應的fitnessGoal 表裡 紀錄currentweight   因為users無currentweight
            FitnessGoal fitnessGoal = new FitnessGoal();
            fitnessGoal.setUsers(existingUsers);
            fitnessGoal.setCurrent_weight(inputData.getCurrent_weight());
            fitnessGoalDao.save(fitnessGoal);
            return true;
		}	
		return false;
	}
//	==========會員更新判斷 end==========
//	==========更改密碼判斷 start========
	public boolean changePassword(PasswordChangeRequest passwordChangeRequest) {
		Users users = usersDao.findByEmail(passwordChangeRequest.getEmail());
		//判斷密碼是否一致  並設為新密碼
		if (users != null && BCrypt.checkpw(passwordChangeRequest.getOldPassword(),users.getPassword())) {
			users.setPassword(BCrypt.hashpw(passwordChangeRequest.getNewPassword(),BCrypt.gensalt()));
			usersDao.save(users);
			return true;
		}
		return false;		
	}	
//	==========更改密碼判斷 end========
	
	
//login.jsp用到的
//	==========會員登入判斷 start==========
	public boolean checkUser(Users users) {
		//找到email後判斷密碼是否正確
	Users chUsers = usersDao.findByEmail(users.getEmail());
	if(chUsers != null && chUsers.getPassword().equals(users.getPassword())) {
		return true;
	}
		return false;
	}

//	登入以Email作為辨別 start
	public Users getUserByEmail(String email) {
		//控制器中傳遞的是字串類型的 email 参数
		
		return usersDao.findByEmail(email);
	}
	
	public Users getUserIdByEmail(String email) {
        return usersDao.findByEmail(email);
                
    }
//	登入以Email作為辨別 end
//	==========會員登入判斷 end==========	
	
	
// bodyreport.jsp用到的	
//	===找fitnessGoal最新一筆資料 start
	public Optional<IndexInput> getUserWeight(String email){
		Users users = usersDao.findByEmail(email);
		
		if(users == null) {
			return Optional.empty();
		}
		
		Optional<FitnessGoal> fitnessGoals = fitnessGoalDao.findTopByUsersEmailOrderByUpdateAtDescNative(email);
		if (!fitnessGoals.isPresent()) {
			return Optional.empty();
		}
		
		FitnessGoal latestFitnessGoal = fitnessGoals.get();
		
		IndexInput indexInput = new IndexInput(users, latestFitnessGoal);
		return Optional.of(indexInput);
	}
	
//	===找fitnessGoal最新一筆資料 end	
//	===找fitnessGoal所有ID體重的資料 start
		public Optional<WeightChart> getWeightChart(String email){
			Users users = usersDao.findByEmail(email);
			if (users == null) {
				return Optional.empty();
			}
			
			List<BigDecimal> weights = fitnessGoalDao.findCurrentWeightsByUserEmail(email);
			if(weights.isEmpty()) {
				return Optional.empty();
			}
			
			WeightChart weightChart = new WeightChart(users, weights);
			return Optional.of(weightChart);
		}

//	===找fitnessGoal所有ID體重的資料 end		
		
		
//dashboard.jsp
		//============簽到日歷 start=============	
		public Users getUserById(int userId) {
			return usersDao.findById(userId).orElse(null);
		}
		//============簽到日歷 end=============
		
//signin.jsp用
		//============加密 start=============
		//確認有無相同email
		public boolean isAccountExist(String email){
	        return usersDao.existsByEmail(email);
	    }
		
//		//建立
//		 public Users addNew(String email, String password, String real_name) {
//		        Users users = new Users();
//		        users.setEmail(email);
//		        users.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
//		        users.setReal_name(real_name);
//		        return usersDao.save(users);  
//		    }
		
		 
//		 public Users saveUser(Users users) {
//			    Users existingUser = usersDao.findByEmail(users.getEmail());
//			    if (existingUser != null) {
//			        throw new RuntimeException("User already exists");
//			    }
//			    return usersDao.save(users);
//			}

		//============加密 end=============
	}
	


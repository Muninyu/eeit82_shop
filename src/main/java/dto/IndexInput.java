package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.example.demo.FitnessGoal;

import com.example.demo.Users;

public class IndexInput {

	private String nickname;
	 private String email;
	    private String gender;
	    private Date birthday;
	    private String phone;
	    private BigDecimal height_cm;
	    private BigDecimal current_weight;
	    private String face;
	    private Timestamp update_at;
	    private String activity_level;
		private String purpose;
	    private List<FitnessGoalDto> fitnessGoals;
	    private int age;
	    private BigDecimal target_weight;
	    
	    public  IndexInput(Users users, FitnessGoal latestFitnessGoal) {
	        this.nickname = users.getNickname();
	        this.email = users.getEmail();
	        this.gender = users.getGender();
	        this.birthday = users.getBirthday();
	        this.phone = users.getPhone();
	        this.height_cm = users.getHeight_cm();
	        this.face = users.getFace();
	        this.activity_level = users.getActivity_level();
	        this.purpose = users.getPurpose();
	        this.age = users.getAge();
	        this.target_weight = users.getTarget_weight();
	        if (latestFitnessGoal != null) {
	            this.current_weight = latestFitnessGoal.getCurrent_weight();
	        }
	     
	    }
	    
	    
		public BigDecimal getTarget_weight() {
			return target_weight;
		}


		public void setTarget_weight(BigDecimal target_weight) {
			this.target_weight = target_weight;
		}


		public int getAge() {
			return age;
		}


		public void setAge(int age) {
			this.age = age;
		}


		public String getActivity_level() {
			return activity_level;
		}


		public void setActivity_level(String activity_level) {
			this.activity_level = activity_level;
		}


		public String getPurpose() {
			return purpose;
		}


		public void setPurpose(String purpose) {
			this.purpose = purpose;
		}


		public Timestamp getUpdate_at() {
			return update_at;
		}


		public void setUpdate_at(Timestamp update_at) {
			this.update_at = update_at;
		}


		


		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getGender() {
			return gender;
		}

		public void setGender(String gender) {
			this.gender = gender;
		}

		public Date getBirthday() {
			return birthday;
		}

		public void setBirthday(Date birthday) {
			this.birthday = birthday;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		

		

		public BigDecimal getHeight_cm() {
			return height_cm;
		}


		public void setHeight_cm(BigDecimal height_cm) {
			this.height_cm = height_cm;
		}


		public List<FitnessGoalDto> getFitnessGoals() {
			return fitnessGoals;
		}


		public void setFitnessGoals(List<FitnessGoalDto> fitnessGoals) {
			this.fitnessGoals = fitnessGoals;
		}


		public BigDecimal getCurrent_weight() {
			return current_weight;
		}

		public void setCurrent_weight(BigDecimal current_weight) {
			this.current_weight = current_weight;
		}

		public String getFace() {
			return face;
		}

		public void setFace(String face) {
			this.face = face;
		}
		public static class FitnessGoalDto {
	        private double current_weight;
	        private String update_at;
			public double getCurrent_weight() {
				return current_weight;
			}
			public void setCurrent_weight(double current_weight) {
				this.current_weight = current_weight;
			}
			public String getUpdate_at() {
				return update_at;
			}
			public void setUpdate_at(String update_at) {
				this.update_at = update_at;
			}
	        
	        
	        // getters and setters
	    }
}

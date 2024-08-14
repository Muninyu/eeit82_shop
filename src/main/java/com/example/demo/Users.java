package com.example.demo;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class Users {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer user_id;
	private String real_name;
	private String email;
	private String password;
	private String nickname;
	private String gender;
	 
	 @Temporal(TemporalType.DATE)
	    private Date birthday;
	 
	 private int age;
	 private String phone;
	 
	 @Column(precision = 5, scale = 2)
	 	private BigDecimal height_cm;
	 
	 @Column(name="target_weight_kg" , precision = 5, scale = 2)
	 	private BigDecimal target_weight;
	 
	 @Column(columnDefinition = "TEXT")
	    private String face;  
	 
	 private String activity_level;
	 private String purpose;
	 
	 @OneToMany(mappedBy = "users", cascade = CascadeType.ALL,fetch = FetchType.LAZY, orphanRemoval = true)
	 @JsonManagedReference
	 private List<FitnessGoal> fitnessGoals = new ArrayList<>();

	

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getReal_name() {
		return real_name;
	}

	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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
		this.age = calculateAge();
	}

	private int calculateAge() {
        LocalDate birthLocalDate = new java.sql.Date(birthday.getTime()).toLocalDate();
        return Period.between(birthLocalDate, LocalDate.now()).getYears();
    }
	public int getAge() {
		return age;
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

	public BigDecimal getTarget_weight() {
		return target_weight;
	}

	public void setTarget_weight(BigDecimal target_weight) {
		this.target_weight = target_weight;
	}

	public String getFace() {
		return face;
	}

	public void setFace(String face) {
		this.face = face;
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

	public List<FitnessGoal> getFitnessGoals() {
		return fitnessGoals;
	}

	public void setFitnessGoals(List<FitnessGoal> fitnessGoals){
		this.fitnessGoals = fitnessGoals;
	}
	public void addFitnessGoal(FitnessGoal fitnessGoal) {
		fitnessGoals.add(fitnessGoal);
		fitnessGoal.setUsers(this);
    }

    public void removeFitnessGoal(FitnessGoal fitnessGoal) {
    	fitnessGoals.remove(fitnessGoal);
    	fitnessGoal.setUsers(null);
    } 
    
}

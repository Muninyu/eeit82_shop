package com.example.demo;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "Fitness_Goals")
public class FitnessGoal {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int goal_id;
	
	 @ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "user_id")
	 @JsonBackReference
	 private Users users;
	 
	 @Column(precision = 5, scale = 2)
	 	private BigDecimal current_weight;
	
	 @Column(name = "updated_at",nullable = false, updatable = false, insertable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	    private Timestamp update_at;
	 

	 @PrePersist
	    protected void onCreate() {
	        this.update_at = new Timestamp(System.currentTimeMillis());
	    }


	public int getGoal_id() {
		return goal_id;
	}


	public void setGoal_id(int goal_id) {
		this.goal_id = goal_id;
	}


	public Users getUsers() {
		return users;
	}


	public void setUsers(Users users) {
		this.users = users;
	}


	public BigDecimal getCurrent_weight() {
		return current_weight;
	}


	public void setCurrent_weight(BigDecimal current_weight) {
		this.current_weight = current_weight;
	}


	public Timestamp getUpdate_at() {
		return update_at;
	}


	public void setUpdate_at(Timestamp update_at) {
		this.update_at = update_at;
	}
	 
	 
}

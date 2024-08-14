package com.example.demo;



import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
public class Checkinlogs {
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private int chlog_id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	 @JoinColumn(name = "user_id")
	 @JsonBackReference
	 private Users users;
	
//	@Temporal(TemporalType.TIME)
//	private Calendar checkin_time;
	
	@Temporal(TemporalType.DATE)
	private Date checkin_date;

	public int getChlog_id() {
		return chlog_id;
	}

	public void setChlog_id(int chlog_id) {
		this.chlog_id = chlog_id;
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}



	public Date getCheckin_date() {
		return checkin_date;
	}

	public void setCheckin_date(Date checkin_date) {
		this.checkin_date = checkin_date;
	}
	
	
}
package com.example.demo;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "sport_calories") // 確保表名與資料庫中的表名匹配
public class SportCalories {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long sport_id; // 对应数据库中的 sport_id

	@ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private Users users; // 对应数据库中的 user_id

	@Column(name = "sport_calories")
	private double sportCalories; // 对应数据库中的 sport_calories

	@Column(name = "sport_date")
	private LocalDate sportDate; // 对应数据库中的 sport_date

	// Getters 和 Setters
	public Long getSportId() {
		return sport_id;
	}

	public void setSportId(Long sport_id) {
		this.sport_id = sport_id;
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public double getSportCalories() {
		return sportCalories;
	}

	public void setSportCalories(double sportCalories) {
		this.sportCalories = sportCalories;
	}

	public LocalDate getSportDate() {
		return sportDate;
	}

	public void setSportDate(LocalDate sportDate) {
		this.sportDate = sportDate;
	}
}

package com.example.demo;

import java.time.LocalDate;

public class DailyCalories {

	private LocalDate date;
	private Long totalCalories;

	public DailyCalories(LocalDate date, Long totalCalories) {
		this.date = date;
		this.totalCalories = totalCalories;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public Long getTotalCalories() {
		return totalCalories;
	}

	public void setTotalCalories(Long totalCalories) {
		this.totalCalories = totalCalories;
	}

	
	
}

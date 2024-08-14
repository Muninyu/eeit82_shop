package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.example.demo.repository")
public class MyPlan1Application {

	public static void main(String[] args) {
		SpringApplication.run(MyPlan1Application.class, args);
	}

}

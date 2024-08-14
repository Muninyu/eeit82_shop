package com.example.demo.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Users;



@Repository
public interface UsersRepository extends JpaRepository<Users, Integer>{
	
	@Query(value = "SELECT user_id FROM users WHERE email = :email", nativeQuery = true)
	Integer findUseridByEmail(@Param("email") String email);
	
	@Query(value = "SELECT * FROM users WHERE email = :email", nativeQuery = true)
	Optional<Users> findUserByEmail(String email);
	
	@Query(value = "SELECT email FROM users WHERE user_id = :user_id", nativeQuery = true)
	Optional<String> findEmailByUserid(Integer user_id);
	
}

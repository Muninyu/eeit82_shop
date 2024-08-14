package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Orders;



@Repository
public interface OrdersRepository extends JpaRepository<Orders, Integer>{
	
	@Query (value = "SELECT * FROM orders WHERE user_id = :user_id", nativeQuery = true)
	List<Orders> findOrdersByUserid(@Param("user_id") Integer user_id);
}

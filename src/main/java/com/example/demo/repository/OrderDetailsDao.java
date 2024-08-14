package com.example.demo.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.OrderDetails;



public interface OrderDetailsDao extends JpaRepository<OrderDetails,Integer > {
	
	@Query (value = "SELECT * FROM order_details WHERE order_id = :order_id", nativeQuery = true)
	List<OrderDetails> findOrderDetailsByOrderid(@Param("order_id") Integer order_id);

}

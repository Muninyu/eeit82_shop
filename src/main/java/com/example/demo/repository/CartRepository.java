package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Cart;



@Repository
public interface CartRepository extends JpaRepository<Cart, Integer>{
	@Query (value = "SELECT * FROM cart WHERE user_id = :user_id", nativeQuery = true)
	List<Cart> findCartByUserid(@Param("user_id") Integer user_id);
	
	@Transactional
    @Modifying
    @Query (value = "DELETE FROM cart WHERE user_id = :user_id AND product_id = :product_id AND specificationscol_id = :spec_id", nativeQuery = true)
    void deleteCartByUseridAndProductid(@Param("user_id") Integer user_id, @Param("product_id") Integer product_id, @Param("spec_id") Integer spec_id);
}

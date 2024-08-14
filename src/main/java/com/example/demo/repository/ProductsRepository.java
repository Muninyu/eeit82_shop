package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Products;



@Repository
public interface ProductsRepository extends JpaRepository<Products, Integer> {
	@Query(value = "SELECT * FROM products ORDER BY sales_quantity DESC LIMIT :number", nativeQuery = true)
    List<Products> findTopProducts(@Param("number") int number);
	
	@Query(value = "SELECT * FROM products WHERE category_id = :category_id", nativeQuery = true)
	List<Products> findProductsByCategory(@Param("category_id") int category_id);
}

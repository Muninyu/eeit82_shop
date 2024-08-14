package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.ProductSpecifications;



@Repository
public interface ProductSpecificationsRepository extends JpaRepository<ProductSpecifications, Integer>{
	@Query(value = "SELECT * FROM product_specifications WHERE product_id = :product_id", nativeQuery = true)
	List<ProductSpecifications> findSpecificationsById(@Param("product_id") int product_id);
}

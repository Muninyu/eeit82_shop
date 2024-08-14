package com.example.demo.repository;




import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Products;



@Repository
public interface ProductsDao extends JpaRepository<Products,Integer > {
	
	@Query(value = "SELECT * FROM products WHERE product_id = :product_id", nativeQuery = true)
	Optional<Products> findProductById(@Param("product_id") Integer product_id);
	
	@Query(value = "SELECT product_id FROM products WHERE product_name LIKE %:productName%", nativeQuery = true)
	List<Integer> findProductsid(@Param("productName") String productName);

	
	


	
}	


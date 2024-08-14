package com.example.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.ProductCategories;




@Repository
public interface ProductCategoriesRepository extends JpaRepository<ProductCategories, Integer>{
	@Query(value = "SELECT * FROM product_categories WHERE category_id = :category_id LIMIT 1", nativeQuery = true)
    Optional<ProductCategories> findByCategoryid(@Param("category_id") int category_id);
}

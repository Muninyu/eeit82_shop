package com.example.demo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product_categories")
public class ProductCategories {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer  category_id;
	@Column(name = "category_name")
	private String category_name;
	
	@Override
	public String toString() {
		return "ProductCategoies [category_id=" + category_id + ", category_name=" + category_name + "]";
	}
	
	public Integer getCategory_id() {
		return category_id;
	}
	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
}

package com.example.demo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class Cart {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer cart_id;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private Users user;
	@ManyToOne
	@JoinColumn(name = "product_id")
	private Products products;
	@ManyToOne
	@JoinColumn(name = "specificationscol_id")
	private ProductSpecifications productSpecifications;
	@Column(name = "cart_quantity")
	private Integer cart_quantity;
	
	@Override
	public String toString() {
		return "Cart [cart_id=" + cart_id + ", user=" + user + ", products=" + products + ", productSpecifications="
				+ productSpecifications + ", cart_quantity=" + cart_quantity + "]";
	}
	
	public Integer getCart_id() {
		return cart_id;
	}
	public void setCart_id(Integer cart_id) {
		this.cart_id = cart_id;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public Products getProducts() {
		return products;
	}
	public void setProducts(Products products) {
		this.products = products;
	}
	public ProductSpecifications getProductSpecifications() {
		return productSpecifications;
	}
	public void setProductSpecifications(ProductSpecifications productSpecifications) {
		this.productSpecifications = productSpecifications;
	}
	public Integer getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(Integer cart_quantity) {
		this.cart_quantity = cart_quantity;
	}
}

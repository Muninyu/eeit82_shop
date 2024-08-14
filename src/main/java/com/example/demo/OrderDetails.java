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
@Table(name = "order_details")
public class OrderDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer order_detail_id;
	@ManyToOne
	@JoinColumn(name = "order_id")
	private Orders orders;
	@ManyToOne
	@JoinColumn(name = "product_id")
	private Products products;
	@ManyToOne
	@JoinColumn(name = "specificationscol_id")
	private ProductSpecifications productSpecifications;
	@Column(name = "quantity")
	private Integer quantity;
	
	@Override
	public String toString() {
		return "OrderDetails [order_detail_id=" + order_detail_id + ", orders=" + orders + ", products=" + products
				+ ", productSpecifications=" + productSpecifications + ", quantity=" + quantity + "]";
	}

	public Integer getOrder_detail_id() {
		return order_detail_id;
	}

	public void setOrder_detail_id(Integer order_detail_id) {
		this.order_detail_id = order_detail_id;
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
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

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
}

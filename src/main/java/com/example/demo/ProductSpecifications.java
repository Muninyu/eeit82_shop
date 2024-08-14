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
@Table(name = "product_specifications")
public class ProductSpecifications {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer specificationscol_id;
	@ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Products products;
	@Column(name = "spec_name")
	private String spec_name;
	
	@Override
	public String toString() {
		return "ProductSpecifications [specificationscol_id=" + specificationscol_id + ", products=" + products + ", spec_name=" + spec_name
				+ "]";
	}

	public Integer getSpec_id() {
		return specificationscol_id;
	}

	public void setSpec_id(Integer spec_id) {
		this.specificationscol_id = spec_id;
	}

	public Products getProducts() {
		return products;
	}

	public void setProducts(Products products) {
		this.products = products;
	}

	public String getSpec_name() {
		return spec_name;
	}

	public void setSpec_name(String spec_name) {
		this.spec_name = spec_name;
	}
}

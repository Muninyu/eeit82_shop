package com.example.demo;

import org.springframework.web.multipart.MultipartFile;

public class catchNewProduct {
	private Integer product_id;
	private String product_name;
	private String subtitle;
	private String description;
	private Integer price;
	private Integer category_id;
	private MultipartFile image_base64;
	private Integer stock_quantity;
	private Integer sales_quantity;
	public Integer getProduct_id() {
		return product_id;
	}
	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getCategory_id() {
		return category_id;
	}
	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}
	public MultipartFile getImage_base64() {
		return image_base64;
	}
	public void setImage_base64(MultipartFile image_base64) {
		this.image_base64 = image_base64;
	}
	public Integer getStock_quantity() {
		return stock_quantity;
	}
	public void setStock_quantity(Integer stock_quantity) {
		this.stock_quantity = stock_quantity;
	}
	public Integer getSales_quantity() {
		return sales_quantity;
	}
	public void setSales_quantity(Integer sales_quantity) {
		this.sales_quantity = sales_quantity;
	}
	
}

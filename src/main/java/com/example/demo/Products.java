package com.example.demo;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "products")
public class Products {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer product_id;
	@Column(name = "product_name")
	private String product_name;
	@Column(name = "subtitle")
	private String subtitle;
	@Column(name = "description")
	private String description;
	@Column(name = "price")
	private Integer price;
	@ManyToOne
	@JoinColumn(name = "category_id")
	private ProductCategories productCategories;
	@Column(name = "image_base64")
	private String image_base64;
	@Column(name = "stock_quantity")
	private Integer stock_quantity;
	@Column(name = "sales_quantity")
	private Integer sales_quantity;
	@OneToMany(mappedBy = "products", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ProductSpecifications> productSpecifications;
	
	@Override
	public String toString() {
		return "Products [product_id=" + product_id + ", product_name=" + product_name + ", subtitle=" + subtitle
				+ ", description=" + description + ", price=" + price + ", productCategories=" + productCategories
				+ ", image_base64=" + image_base64 + ", stock_quantity=" + stock_quantity + ", sales_quantity="
				+ sales_quantity + ", productSpecifications=" + productSpecifications + "]";
	}

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

	public ProductCategories getProductCategories() {
		return productCategories;
	}

	public void setProductCategories(ProductCategories productCategories) {
		this.productCategories = productCategories;
	}

	public String getImage_base64() {
		return image_base64;
	}

	public void setImage_base64(String image_base64) {
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

	public Set<ProductSpecifications> getProductSpecifications() {
		return productSpecifications;
	}

	public void setProductSpecifications(Set<ProductSpecifications> productSpecifications) {
		this.productSpecifications = productSpecifications;
	}
}

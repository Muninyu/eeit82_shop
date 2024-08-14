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
@Table(name = "orders")
public class Orders {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer order_id;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private Users users;
	@Column(name = "order_name")
	private String order_name;
	@Column(name = "order_phone")
	private String order_phone;
	@Column(name = "order_date")
	private String order_date;
	@Column(name = "shipping_address")
	private String shipping_address;
	@Column(name = "status")
	private String status;
	
	@Override
	public String toString() {
		return "Orders [order_id=" + order_id + ", users=" + users + ", order_name=" + order_name + ", order_phone="
				+ order_phone + ", order_date=" + order_date + ", shipping_address=" + shipping_address + ", status="
				+ status + "]";
	}
	
	public Integer getOrder_id() {
		return order_id;
	}
	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}
	public Users getUsers() {
		return users;
	}
	public void setUsers(Users users) {
		this.users = users;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_phone() {
		return order_phone;
	}
	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getShipping_address() {
		return shipping_address;
	}
	public void setShipping_address(String shipping_address) {
		this.shipping_address = shipping_address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}

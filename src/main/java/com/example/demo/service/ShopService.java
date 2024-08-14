package com.example.demo.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Cart;
import com.example.demo.OrderDetails;
import com.example.demo.Orders;
import com.example.demo.ProductCategories;
import com.example.demo.ProductSpecifications;
import com.example.demo.Products;
import com.example.demo.Users;
import com.example.demo.repository.CartRepository;
import com.example.demo.repository.OrderDetailsRepository;
import com.example.demo.repository.OrdersRepository;
import com.example.demo.repository.ProductCategoriesRepository;
import com.example.demo.repository.ProductSpecificationsRepository;
import com.example.demo.repository.ProductsRepository;
import com.example.demo.repository.UsersRepository;



@Service
public class ShopService {
	@Autowired
	private ProductsRepository productsRepository;
	
	@Autowired
	private ProductCategoriesRepository productCategoriesRepository;
	
	@Autowired
	private ProductSpecificationsRepository productSpecificationsRepository;
	
	@Autowired
	private UsersRepository usersRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	@Autowired
	private OrdersRepository ordersRepository;
	
	@Autowired
	private OrderDetailsRepository orderDetailsRepository;
	
	public List<Products> getRandomProducts(int number){
		List<Products> randomProducts = productsRepository.findAll();
		Collections.shuffle(randomProducts);
		return randomProducts.stream().limit(number).collect(Collectors.toList());
	}
	
	public List<Products> getTopProducts(int number){
	    return productsRepository.findTopProducts(number);
	}
	
	public Optional<ProductCategories> getCategoryById(int category_id) {
		return productCategoriesRepository.findByCategoryid(category_id);
	}
	
	public List<Products> getProductsByCategory(int category_id){
	    return productsRepository.findProductsByCategory(category_id);
	}
	
	public Optional<Products> getProductById(int product_id) {
		return productsRepository.findById(product_id);
	}
	
	public List<ProductSpecifications> getProductSpecifications(int product_id){
		return productSpecificationsRepository.findSpecificationsById(product_id);
	}

	public Integer getUseridByEmail(String email) {
		return usersRepository.findUseridByEmail(email);
	}

	public List<Cart> getCartByUserid(Integer user_id) {
		return cartRepository.findCartByUserid(user_id);
	}
	
	public void addNewCart(Integer user_id, Integer product_id, Integer spec_id, Integer cart_quantity){
		Users users = usersRepository.findById(user_id).orElseThrow(() -> new RuntimeException("User not found"));
		Products products = productsRepository.findById(product_id).orElseThrow(() -> new RuntimeException("Product not found"));
		ProductSpecifications productSpecifications = productSpecificationsRepository.findById(spec_id).orElseThrow(() -> new RuntimeException("Specifications not found"));
		Cart cart = new Cart();
		cart.setUser(users);
		cart.setProducts(products);
		cart.setProductSpecifications(productSpecifications);
		cart.setCart_quantity(cart_quantity);
		cartRepository.save(cart);
	}

	public void deleteOldCart(Integer user_id, Integer product_id, Integer spec_id) {
		cartRepository.deleteCartByUseridAndProductid(user_id, product_id, spec_id);
	}

	public void updateOldCart(Integer user_id, Integer product_id, Integer spec_id, Integer cart_quantity) {
		Users users = usersRepository.findById(user_id).orElseThrow(() -> new RuntimeException("User not found"));
		Products products = productsRepository.findById(product_id).orElseThrow(() -> new RuntimeException("Product not found"));
		ProductSpecifications productSpecifications = productSpecificationsRepository.findById(spec_id).orElseThrow(() -> new RuntimeException("Specifications not found"));
		Cart cart = new Cart();
		cart.setUser(users);
		cart.setProducts(products);
		cart.setProductSpecifications(productSpecifications);
		cart.setCart_quantity(cart_quantity);
		cartRepository.deleteCartByUseridAndProductid(user_id, product_id, spec_id);
		cartRepository.save(cart);
	}
	
	public Optional<Users> getUserByEmail(String email) {
		return usersRepository.findUserByEmail(email);
	}
	
	public void createNewOrder(Users user, String order_name, String order_phone, String shipping_address) {
		Orders orders = new Orders();
		orders.setUsers(user);
		orders.setOrder_name(order_name);
		orders.setOrder_phone(order_phone);
		LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedNow = now.format(formatter);
		orders.setOrder_date(formattedNow);
		orders.setShipping_address(shipping_address);
		orders.setStatus("待處理");
		ordersRepository.save(orders);
		
		List<Cart> carts = cartRepository.findCartByUserid(user.getUser_id());
		for (Cart tempCart : carts) {
			OrderDetails orderDetails = new OrderDetails();
			orderDetails.setOrders(orders);
			orderDetails.setProducts(tempCart.getProducts());
			orderDetails.setProductSpecifications(tempCart.getProductSpecifications());
			orderDetails.setQuantity(tempCart.getCart_quantity());
			orderDetailsRepository.save(orderDetails);
			cartRepository.delete(tempCart);
		}
	}

	public List<Orders> getOrdersByUserid(Integer user_id) {
		return ordersRepository.findOrdersByUserid(user_id);
	}

	public Map<Integer, List<OrderDetails>> getOrderDetailsByUserid(Integer user_id, List<Orders> orders) {
		Map<Integer, List<OrderDetails>> orderDetailsWithAllOrders = new HashMap<>();
		for (Orders tempOrders : orders) {
			Integer order_id = tempOrders.getOrder_id();
			List<OrderDetails> orderDetailsWithOneOrder = orderDetailsRepository.findOrderDetailsByOrderid(order_id);
			orderDetailsWithAllOrders.put(order_id, orderDetailsWithOneOrder);
		}
		return orderDetailsWithAllOrders;
	}

	public Optional<String> getEmailByUserid(Integer user_id) {
		return usersRepository.findEmailByUserid(user_id);
	}
}
package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.OrderDetails;
import com.example.demo.Orders;
import com.example.demo.ProductCategories;
import com.example.demo.Products;
import com.example.demo.repository.OrderDetailsDao;
import com.example.demo.repository.OrdersDao;
import com.example.demo.repository.ProductCategoriesDao;
import com.example.demo.repository.ProductsDao;

@Service
public class SellerService {
	@Autowired
	private ProductsDao productsDao;
	
	@Autowired
	private ProductCategoriesDao productCategoriesDao;
	

	@Autowired
	private OrdersDao orderDao;
	
	@Autowired
	private OrderDetailsDao orderDetailsDao;
	
	
	//顯示商品
	public List<Products> getProducts(){
		return productsDao.findAll();
	}
	

	
	public List<Orders> getOrders(){
		return orderDao.findAll();
	}
	
	public List<OrderDetails> getOrderDetails(){
		return orderDetailsDao.findAll();
	}
	
	public Map<Integer, List<OrderDetails>> getOrderDetailsByOrderid(List<Orders> orders) {
        Map<Integer, List<OrderDetails>> orderDetailsWithAllOrders = new HashMap<>();
        for (Orders tempOrders : orders) {
            Integer order_id = tempOrders.getOrder_id();
            List<OrderDetails> orderDetailsWithOneOrder = orderDetailsDao.findOrderDetailsByOrderid(order_id);
            orderDetailsWithAllOrders.put(order_id, orderDetailsWithOneOrder);
        }
        return orderDetailsWithAllOrders;
    }
	
	

	
	
    // 新增商品
	public Products addProducts(Products product) {
	    Products savedProduct = productsDao.save(product);
	    return savedProduct;
	}


	public Optional<ProductCategories> getProductCategoriesByCategoryid(Integer category_id) {
		return productCategoriesDao.findById(category_id);
	}


	public Optional<Products> getProduct1(Integer product_id) {
		return productsDao.findProductById(product_id);
	}
	
	public Products updateProduct(Products product) {
	    Products savedProduct = productsDao.save(product);
	    return savedProduct;
	}


    // 保存商品的方法定义
    public Products saveProducts(Products product) {
        // 实现具体逻辑
        return productsDao.save(product);
        
    }
    public void deleteProduct(Integer productId) {
        // 如果需要，可以添加其他业务逻辑，比如检查商品是否存在等
        productsDao.deleteById(productId);
    }
    
    
    public List<Integer> searchProductsid(String productName) {
        return productsDao.findProductsid(productName);
    }


	public List<Products> getProductsByProductid(List<Integer> product_id) {
		return productsDao.findAllById(product_id);
	}
	

	
	


    


    

    
    



    





	
	
	
	

}

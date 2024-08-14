package com.example.demo.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.hibernate.query.criteria.internal.expression.function.AggregationFunction.SUM;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.ContactUs;
import com.example.demo.OrderDetails;
import com.example.demo.Orders;
import com.example.demo.ProductCategories;
import com.example.demo.Products;
import com.example.demo.catchNewProduct;
import com.example.demo.service.ContactUsService;
import com.example.demo.service.SellerService;

@Controller
public class SellerComtroller {
	
	
	private final SellerService sellerService;
	
	private final ContactUsService contactUsService;
	
	
	@Autowired
	public SellerComtroller (SellerService sellerService, ContactUsService contactUsService) {
		this.sellerService = sellerService;
		this.contactUsService = contactUsService;
	}
	
	@GetMapping("/sellerOrder")
    public String index113(Model model) {
		List<Orders> orders = sellerService.getOrders();
		model.addAttribute("orders",orders);
		Map<Integer, List<OrderDetails>> orderDetailsAll = sellerService.getOrderDetailsByOrderid(orders);
		List<Integer> ordersum = new ArrayList<>();
		for(Map.Entry<Integer, List<OrderDetails>> temp: orderDetailsAll.entrySet()) {
			Integer ordersumtemp = 0; 
			for(OrderDetails temp2 : temp.getValue()) {
				Integer temp3 = temp2.getProducts().getPrice()*temp2.getQuantity();
				ordersumtemp = ordersumtemp + temp3;
			}
			ordersum.add(ordersumtemp);
		}
		model.addAttribute("ordersum",ordersum);
		model.addAttribute("orderDetailsAll", orderDetailsAll);
		return "113"; // 返回靜態檔案的名稱，Spring Boot 會自動找到對應的檔案在 static 目錄下 
    }

	
	@GetMapping("/seller")
    public String index111(Model model) {
		List<Orders> orders = sellerService.getOrders();
		model.addAttribute("orders",orders);
		Map<Integer, List<OrderDetails>> orderDetailsAll = sellerService.getOrderDetailsByOrderid(orders);
		List<Integer> ordersum = new ArrayList<>();
		for(Map.Entry<Integer, List<OrderDetails>> temp: orderDetailsAll.entrySet()) {
			Integer ordersumtemp = 0; 
			for(OrderDetails temp2 : temp.getValue()) {
				Integer temp3 = temp2.getProducts().getPrice()*temp2.getQuantity();
				ordersumtemp = ordersumtemp + temp3;
			}
			ordersum.add(ordersumtemp);
		}
		model.addAttribute("ordersum",ordersum);
		model.addAttribute("orderDetailsAll", orderDetailsAll);
        return "111"; // 返回靜態檔案的名稱，Spring Boot 會自動找到對應的檔案在 static 目錄下
    }
	
	@GetMapping("/sellerProducts")
	public String show112(Model model) {
		List<Products> productsList = sellerService.getProducts();
		model.addAttribute("productsList",productsList);
		
		return "112";
		
	}
	
	@PostMapping("/add1")
	public String addProducts( catchNewProduct catchNewProduct1, Model model) {
		Products products = new Products();
		products.setProduct_name(catchNewProduct1.getProduct_name());
		products.setSubtitle(catchNewProduct1.getSubtitle());
		products.setDescription(catchNewProduct1.getDescription());
		products.setPrice(catchNewProduct1.getPrice());
		Optional<ProductCategories> productCategories = sellerService.getProductCategoriesByCategoryid(catchNewProduct1.getCategory_id());
		products.setProductCategories(productCategories.get());
		
		try {
			String base64Image = Base64.getEncoder().encodeToString(catchNewProduct1.getImage_base64().getBytes());
			products.setImage_base64(base64Image);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println(e);
		}
		
		products.setStock_quantity(catchNewProduct1.getStock_quantity());
		products.setSales_quantity(catchNewProduct1.getSales_quantity());
		sellerService.addProducts(products);
		return "redirect:/sellerProducts";
	}
	

	
	
	@PostMapping("/editProducts")
    public ResponseEntity<Map<String, Object>> editProduct(@RequestBody Map<String, Object> product) {
		String product_id = (String)product.get("product_id");
		Integer product_idInteger = Integer.parseInt(product_id);
		
        Optional<Products> product1 = sellerService.getProduct1(product_idInteger);
        Map<String, Object> productNew = new HashMap<>();
        productNew.put("product_id", product1.get().getProduct_id());
        productNew.put("product_name", product1.get().getProduct_name());
        productNew.put("subtitle", product1.get().getSubtitle());
        productNew.put("description", product1.get().getDescription());
        productNew.put("price", product1.get().getPrice());
        productNew.put("productCategories", product1.get().getProductCategories());
        productNew.put("image_base64", product1.get().getImage_base64());
        productNew.put("stock_quantity", product1.get().getStock_quantity());
        productNew.put("sales_quantity", product1.get().getSales_quantity());
         
        
        
        return ResponseEntity.ok(productNew);
       
    }
	
	
	
	@PostMapping("/renew")
	public ResponseEntity<String> renewProduct(
			
			@RequestParam("edit_sales_id") String productId,
	        @RequestParam("edit_product_name") String productName,
	        @RequestParam("edit_subtitle") String subtitle,
	        @RequestParam("edit_description") String description,
	        @RequestParam("edit_price") Integer price,
	        @RequestParam("edit_category_id") ProductCategories categoryId,
	        @RequestParam("edit_image_base64") MultipartFile imageFile,
	        @RequestParam("edit_stock_quantity") int stockQuantity,
	        @RequestParam("edit_sales_quantity") int salesQuantity) {

	    Products product = new Products();
	    Integer productIdInteger = Integer.parseInt(productId);
	    product.setProduct_id(productIdInteger);
	    product.setProduct_name(productName);
	    product.setSubtitle(subtitle);
	    product.setDescription(description);
	    product.setPrice(price);
	    product.setProductCategories(categoryId);
	    product.setStock_quantity(stockQuantity);
	    product.setSales_quantity(salesQuantity);

	    try {
	        if (!imageFile.isEmpty()) {
	            byte[] imageData = imageFile.getBytes();
	            String base64Image = Base64.getEncoder().encodeToString(imageData);
	            product.setImage_base64(base64Image);
	        }

	        // 使用SellerService保存商品到数据库
	        sellerService.saveProducts(product);

	        return ResponseEntity.ok("商品更新成功");
	    } catch (IOException e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("更新失败：" + e.getMessage());
	    }
	}
	
	
    @PostMapping("/deleteProduct/{productId}")
    public ResponseEntity<String> deleteProduct(@PathVariable Integer productId) {
        sellerService.deleteProduct(productId);
        return ResponseEntity.ok("Product deleted successfully");
    }
    
    
    @PostMapping("/searchProducts")
    public ResponseEntity<List<Integer>> searchProducts(@RequestBody Map<String, String> request) {
        String productName = request.get("productName");
        List<Integer> products_id =sellerService.searchProductsid(productName);
        System.out.println(products_id);
        return ResponseEntity.ok(products_id);
    }
    
    @GetMapping("/search")
    public String showSearch(Model model, @RequestParam List<Integer> product_id) {
		List<Products> productsList = sellerService.getProductsByProductid(product_id);
		model.addAttribute("productsList",productsList);
		
		return "112";
		
	}
    
    
 // 添加获取联络表单数据的方法
    @GetMapping("/sellercontact")
    public String getSellerContactPage(Model model) {
        List<ContactUs> contactUsList = contactUsService.findAll();
        model.addAttribute("contactUsList", contactUsList);
        return "contactus";
    }

    @GetMapping("/contact/{id}")
    public String getContactDetail(@PathVariable Integer id, Model model) {
        Optional<ContactUs> contactUsOptional = contactUsService.findById(id);
        if (contactUsOptional.isPresent()) {
            model.addAttribute("contactUs", contactUsOptional.get());
            return "contact-detail";
        } else {
            return "content/notfound";
        }
    }
    
    

    
	
	
	
	

	

}

package com.example.demo.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.Cart;
import com.example.demo.OrderDetails;
import com.example.demo.Orders;
import com.example.demo.ProductCategories;
import com.example.demo.ProductSpecifications;
import com.example.demo.Products;
import com.example.demo.Users;
import com.example.demo.service.ShopService;

import ecpay.logistics.integration.AllInOne;
import ecpay.logistics.integration.domain.ExpressMapObj;
import ecpay.payment.integration.domain.AioCheckOutALL;



@Controller
public class ShopController {
	@Autowired
	private ShopService shopService;
	
	private AllInOne allInOneLog = new AllInOne();
	private ecpay.payment.integration.AllInOne allInOnePay = new ecpay.payment.integration.AllInOne(null);
//	----------------------------------------------
//	-----------------------------------------
	
	@GetMapping("/shop")
	public String showShopIndex(Model model, HttpSession session) {
		List<Products> randomProducts = shopService.getRandomProducts(4);
		List<Products> topProducts = shopService.getTopProducts(6);
		String email = (String)session.getAttribute("logInEmail");
		if (email == null) {
            return "redirect:/test3"; // 如果用户未登录，重定向到登录页面
        }
		Integer user_id = shopService.getUseridByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user_id);
		model.addAttribute("randomProducts", randomProducts);
		model.addAttribute("topProducts", topProducts);
		model.addAttribute("carts",carts);
		return "shop-index";
	}
	
	@GetMapping("/shop/class/{category_id}")
	public String showShopClass(Model model, @PathVariable int category_id, HttpSession session) {
		Optional<ProductCategories> category = shopService.getCategoryById(category_id);
		List<Products> productsCategory = shopService.getProductsByCategory(category_id);
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user_id);
		if (category.isPresent()) {
            model.addAttribute("category", category.get());
            model.addAttribute("productsCategory", productsCategory);
            model.addAttribute("carts",carts);
            return "shop-class";
        } else {
            return "redirect:/error";
        }
	}
	
	@GetMapping("/shop/product/{product_id}")
	public String showShopProduct(Model model, @PathVariable int product_id, HttpSession session) {
		Optional<Products> product = shopService.getProductById(product_id);
		List<ProductSpecifications> productSpecification = shopService.getProductSpecifications(product_id);
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user_id);
		if (product.isPresent()) {
            model.addAttribute("product", product.get());
            model.addAttribute("productSpecification", productSpecification);
            model.addAttribute("carts",carts);
            return "shop-product";
        } else {
            return "redirect:/error";
        }
	}
	
	@GetMapping("/shop/cart")
	public String showShopCart(Model model, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user_id);
		model.addAttribute("carts",carts);
		return "shop-cart";
	}
	
	@GetMapping("/shop/order")
	public String showShopOrder(Model model, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user.get().getUser_id());
		model.addAttribute("user",user.get());
		model.addAttribute("carts",carts);
		return "shop-order";
	}
	
	@GetMapping("/shop/checkout")
	public String showShopCheckout(Model model, HttpSession session) {
		return "shop-checkout";
	}
	
	@GetMapping("/shop/orderhistory")
	public String showShopOrderHistory(Model model, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user_id);
		List<Orders> orders = shopService.getOrdersByUserid(user_id);
		Map<Integer, List<OrderDetails>> orderDetailsWithAllOrders = shopService.getOrderDetailsByUserid(user_id, orders);
		model.addAttribute("user_id", user_id);
		model.addAttribute("carts", carts);
		model.addAttribute("orders", orders);
		model.addAttribute("orderDetailsWithAllOrders", orderDetailsWithAllOrders);
		return "shop-orderhistory";
	}
	
	@PostMapping("/addToCart")
	public ResponseEntity<String> addToCart(@RequestBody Map<String, Object> cartObject, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		Integer product_id = (Integer)cartObject.get("product_id");
		String spec_id = (String)cartObject.get("spec_id");
		Integer spec_idInteger = Integer.parseInt(spec_id);
		String quantity = (String) cartObject.get("quantity");
		Integer quantityInteger = Integer.parseInt(quantity);
		shopService.addNewCart(user_id, product_id, spec_idInteger, quantityInteger);
        return new ResponseEntity<String>("success", HttpStatus.NO_CONTENT);
	}
	
	@PostMapping("/deleteFromCart")
	public ResponseEntity<String> deleteFromCart(@RequestBody Map<String, Object> cartObject, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		String product_id = (String)cartObject.get("product_id");		
		Integer product_idInteger = Integer.parseInt(product_id);
		String spec_id = (String)cartObject.get("spec_id");		
		Integer spec_idInteger = Integer.parseInt(spec_id);
		shopService.deleteOldCart(user_id, product_idInteger, spec_idInteger);
        return new ResponseEntity<String>("success", HttpStatus.NO_CONTENT);
	}
	
	@PostMapping("/updateCart")
	public ResponseEntity<String> updateCart(@RequestBody Map<String, Object> cartObject, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Integer user_id = shopService.getUseridByEmail(email);
		String product_id = (String)cartObject.get("product_id");		
		Integer product_idInteger = Integer.parseInt(product_id);
		String spec_id = (String)cartObject.get("spec_id");
		Integer spec_idInteger = Integer.parseInt(spec_id);
		String quantity = (String) cartObject.get("quantity");
		Integer quantityInteger = Integer.parseInt(quantity);
		shopService.updateOldCart(user_id, product_idInteger, spec_idInteger, quantityInteger);
        return new ResponseEntity<String>("success", HttpStatus.NO_CONTENT);
	}
	
	@PostMapping("/createOrder")
	public ResponseEntity<String> createOrder(@RequestBody Map<String, Object> orderObject,HttpSession session){
		String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
		String order_name = (String)orderObject.get("order_name");
		String order_phone = (String)orderObject.get("order_phone");
		String shipping_address = (String)orderObject.get("shipping_address");
		shopService.createNewOrder(user.get(), order_name, order_phone, shipping_address);
		return new ResponseEntity<String>("success", HttpStatus.NO_CONTENT);
	}
	
	@GetMapping("/shop/order/store/notpay")
	public String showShopOrderStoreNotpay(Model model, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user.get().getUser_id());
		model.addAttribute("user",user.get());
		model.addAttribute("carts",carts);
		return "shop-order-store";
	}
	
	@PostMapping("/toFamiShopChoice/notpay")
	@ResponseBody
	public String toExpressMapNotpay(@RequestBody Map<String, Object> mapObject, HttpSession session) {
	    String IsCollection = (String)mapObject.get("IsCollection");
	    ExpressMapObj mapObj  = new ExpressMapObj();
	    mapObj.setMerchantID("2000132");
	    mapObj.setMerchantTradeNo("QWas123456789");
	    mapObj.setLogisticsSubType("FAMI");
	    mapObj.setIsCollection(IsCollection);
	    mapObj.setServerReplyURL("http://localhost:8080/shop/order/store/notpay/choice");
	    String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
	    mapObj.setExtraData(user.get().getUser_id().toString());
	    String expressMapResponse = allInOneLog.expressMap(mapObj);
	    return expressMapResponse;
	}

	@PostMapping("/shop/order/store/notpay/choice")
	public String showShopOrderStoreNotpayChoice(@RequestParam Map<String, Object> mapObject, Model model, HttpSession session) {
		String user_id = (String)mapObject.get("ExtraData");
		Integer user_idInteger = Integer.parseInt(user_id);
		Optional<String> emailString = shopService.getEmailByUserid(user_idInteger);
		session.setAttribute("logInEmail", emailString.get());
	    String email = (String)session.getAttribute("logInEmail");
	    Optional<Users> user = shopService.getUserByEmail(email);
        List<Cart> carts = shopService.getCartByUserid(user.get().getUser_id());
        String store = "全家" + mapObject.get("CVSStoreName");
        model.addAttribute("user", user.get());
        model.addAttribute("carts", carts);
        model.addAttribute("store", store);
        return "shop-order-store";
	}
	
	@GetMapping("/shop/order/store/pay")
	public String showShopOrderStorePay(Model model, HttpSession session) {
		String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
		List<Cart> carts = shopService.getCartByUserid(user.get().getUser_id());
		model.addAttribute("user",user.get());
		model.addAttribute("carts",carts);
		return "shop-order-store-pay";
	}
	
	@PostMapping("/toFamiShopChoice/pay")
	@ResponseBody
	public String toExpressMapPay(@RequestBody Map<String, Object> mapObject, HttpSession session) {
	    String IsCollection = (String)mapObject.get("IsCollection");
	    ExpressMapObj mapObj  = new ExpressMapObj();
	    mapObj.setMerchantID("2000132");
	    mapObj.setMerchantTradeNo("QWas123456789");
	    mapObj.setLogisticsSubType("FAMI");
	    mapObj.setIsCollection(IsCollection);
	    mapObj.setServerReplyURL("http://localhost:8080/shop/order/store/pay/choice");
	    String email = (String)session.getAttribute("logInEmail");
		Optional<Users> user = shopService.getUserByEmail(email);
	    mapObj.setExtraData(user.get().getUser_id().toString());
	    String expressMapResponse = allInOneLog.expressMap(mapObj);
	    return expressMapResponse;
	}
	
	@PostMapping("/shop/order/store/pay/choice")
	public String showShopOrderStorePayChoice(@RequestParam Map<String, Object> mapObject, Model model, HttpSession session) {
		String user_id = (String)mapObject.get("ExtraData");
		Integer user_idInteger = Integer.parseInt(user_id);
		Optional<String> emailString = shopService.getEmailByUserid(user_idInteger);
		session.setAttribute("logInEmail", emailString.get());
	    String email = (String)session.getAttribute("logInEmail");
	    Optional<Users> user = shopService.getUserByEmail(email);
        List<Cart> carts = shopService.getCartByUserid(user.get().getUser_id());
        String store = "全家" + mapObject.get("CVSStoreName");
        model.addAttribute("user", user.get());
        model.addAttribute("carts", carts);
        model.addAttribute("store", store);
        return "shop-order-store-pay";
	}
	
	@PostMapping("/toPayment")
	@ResponseBody
	public String toPayment(@RequestBody Map<String, Object> payObject, HttpSession session) {
		AioCheckOutALL payobj = new AioCheckOutALL();
		payobj.setMerchantID("3002607");
		LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        String formattedNow = now.format(formatter);
        payobj.setMerchantTradeDate(formattedNow);
        String email = (String)session.getAttribute("logInEmail");
        Optional<Users> user = shopService.getUserByEmail(email);
        payobj.setCustomField1(user.get().getUser_id().toString());
        Integer tradeNo = (int)Math.round(Math.random()*1000);
        String tradeNoString = "BB" + user.get().getUser_id().toString() + tradeNo.toString();
        payobj.setMerchantTradeNo(tradeNoString);
        String price = (String)payObject.get("price");
        System.out.println(price);
        payobj.setTotalAmount(price);        
        payobj.setTradeDesc("test Description");
        payobj.setItemName("TestItem");
        payobj.setReturnURL("http://localhost:8080");
        payobj.setOrderResultURL("http://localhost:8080/shop/order/store/pay/checkout");
        payobj.setNeedExtraPaidInfo("N");
		
		String form = allInOnePay.aioCheckOut(payobj, null);
		return form;
	}
	
	@PostMapping("/shop/order/store/pay/checkout")
	public String showShopOrderStorePayCheckout(@RequestParam Map<String, Object> mapObject, Model model, HttpSession session) {
		String user_id = (String)mapObject.get("CustomField1");
		Integer user_idInteger = Integer.parseInt(user_id);
		Optional<String> emailString = shopService.getEmailByUserid(user_idInteger);
		session.setAttribute("logInEmail", emailString.get());
		String tradeStatus = (String)mapObject.get("RtnCode");
		if (tradeStatus == "1") {
			System.out.println("成功");
			return "shop-checkout-pay";
		}else {
			System.out.println("失敗");
			return "shop-checkout-pay";
		} 
	}
}
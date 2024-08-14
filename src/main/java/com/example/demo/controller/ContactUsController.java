package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.ContactUs;
import com.example.demo.Users;
import com.example.demo.service.ContactUsService;
import com.example.demo.service.UserService;



@Controller
public class ContactUsController {
	
	@Autowired
    private ContactUsService contactUsService;
	
	@Autowired
    private UserService userService;
	
	@GetMapping("/contact")
    public String showForm(Model model) {
        model.addAttribute("contactUs", new ContactUs());
        return "th/contact";
    }

    @PostMapping("/contact/submit")
    public String submitForm(@ModelAttribute ContactUs contactUs, Model model, RedirectAttributes redirectAttributes) {
        // 檢查 email 是否屬於會員
        Users users = userService.findByEmail(contactUs.getEmail());
        
        if (users != null) {
            // 用戶是會員，設置 users 和 email
            contactUs.setUser(users);
            contactUs.setEmail(users.getEmail());
        } else {
            // 用戶不是會員，只設置 email
            contactUs.setUser(null);
        }

        contactUsService.saveContactUs(contactUs);
        redirectAttributes.addFlashAttribute("message", "表單已成功提交！");
        return "redirect:/success";
    }
    
    
    @GetMapping("/success")
    public String showSuccess() {
        return "th/success";  // 返回顯示成功訊息的空白頁面
    }
    
}



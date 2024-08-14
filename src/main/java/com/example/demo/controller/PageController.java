package com.example.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/page")
public class PageController {

	@GetMapping("/page1")
	public String showPage1() {
		return "/api/caloriesPage";
	}

	@GetMapping("/page2")
	public String showPage2() {
		return "/eat/eatcalories";
	}

	@GetMapping("/page3")
	public String showPage3(HttpSession session, Model model) {
        String email = (String) session.getAttribute("logInEmail");
        if (email == null) {
            return "redirect:/test2"; // 如果用户未登录，重定向到登录页面
        }
       
        return "planindex";
	}

	@GetMapping("/page4")
	public String showPage4() {
		return "sports_abdomen_level1";
	}

	@GetMapping("/page5")
	public String showPage5() {
		return "sports_abdomen_level2";
	}

	@GetMapping("/page6")
	public String showPage6() {
		return "sports_abdomen_level3";
	}

	@GetMapping("/page7")
	public String showPage7() {
		return "sports_arm_level1";
	}

	@GetMapping("/page8")
	public String showPage8() {
		return "sports_arm_level2";
	}
	
	@GetMapping("/page9")
	public String showPage9() {
		return "sports_arm_level3";
	}
	
	@GetMapping("/page10")
	public String showPage10() {
		return "sports_back_level1";
	}
	
	@GetMapping("/page11")
	public String showPage11() {
		return "sports_back_level2";
	}
	
	@GetMapping("/page12")
	public String showPage12() {
		return "sports_back_level3";
	}
	
	@GetMapping("/page13")
	public String showPage13() {
		return "sports_chest_level1";
	}
	
	@GetMapping("/page14")
	public String showPage14() {
		return "sports_chest_level2";
	}
	
	@GetMapping("/page15")
	public String showPage15() {
		return "sports_chest_level3";
	}
	
	@GetMapping("/page16")
	public String showPage16() {
		return "sports_leg_level1";
	}
	
	@GetMapping("/page17")
	public String showPage17() {
		return "sports_leg_level2";
	}
	
	@GetMapping("/page18")
	public String showPage18() {
		return "sports_leg_level3";
	}
	
	
	@GetMapping("/endTraining")
	public String endTraining() {
		return "redirect:/api/caloriesPage"; // 返回的視圖名稱，Spring 會解析為 /WEB-INF/views/GymTrain.jsp
	}
}

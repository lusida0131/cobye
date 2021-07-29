package org.corona.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
//	@GetMapping("/")
//	public String index() {
//		return "/dailyAll/dashboard";
//	}
	
//	@GetMapping("/dailyAll/dashboard")
//	public String dashboard() {
//		return "/dailyAll/dashboard";
//	}
	
//	@GetMapping("/ASA/asa")
//	public String asa() {
//		return "/ASA/asa";
//	}
	
	@GetMapping("/hospital/hospital")
	public String hospital() {
		return "/hospital/hospital";
	}
	
}

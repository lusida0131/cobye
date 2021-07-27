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
	
	/*@GetMapping("/ASA/asa")
	public String asa() {
		return "/ASA/asa";
	}*/
	
	@GetMapping("/page/index")
	public String index1() {
		return "/page/index";
	}
	
	@GetMapping("/hospital/hospital")
	public String hospital() {
		return "/hospital/hospital";
	}
	
	
	
	
	@GetMapping("/page/chart")
	public String chart() {
		return "/page/chart";
	}
	
	
	@GetMapping("/page/chart2")
	public String chart2() {
		return "/page/chart2";
	}
	
	@GetMapping("/page/chart3")
	public String chart3() {
		return "/page/chart3";
	}
	@GetMapping("/page/chart4")
	public String chart4() {
		return "/page/chart4";
	}
	@GetMapping("/page/chart5")
	public String chart5() {
		return "/page/chart5";
	}
}

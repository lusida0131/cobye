package org.corona.controller;


import java.io.IOException;

import org.corona.service.StateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;



@Controller
@RequestMapping
@AllArgsConstructor
@Log4j
public class StateController {
	
	private static final Logger logger = LoggerFactory.getLogger(StateController.class);
	
	private StateService service;
	
	
	@GetMapping("/test")
	public String test() throws IOException {

		String eDay = service.today();	// 기준일 (=종료일)
		String sDay = service.day(eDay);	// 기준일-10일 (=시작일)
		
		service.getCovidStateApi(sDay, eDay);
		
		return "/dailyAll/dashboard";
	}
	
}

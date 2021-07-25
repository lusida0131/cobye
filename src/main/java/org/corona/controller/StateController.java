package org.corona.controller;


import java.io.IOException;
import java.util.ArrayList;

import org.corona.domain.DisasterVO;
import org.corona.domain.StateVO;
import org.corona.service.StateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	
	@GetMapping("/")
	public String test(Model model) throws IOException {

		String eDay = service.today();	// 기준일 (=종료일)
		String sDay = service.day(eDay);	// 기준일-10일 (=시작일)
		
		String result = service.getCovidStateApi(sDay, eDay);
		ArrayList<StateVO> slist = service.covidState(result);
		//System.out.println("covidState slist: " + slist);
		ArrayList<StateVO> alist = service.aCovidState(slist);
		System.out.println("aCovidState alist: " + alist);
		
		int dec = alist.get(0).getDecideCnt();
		int dth = alist.get(0).getDeathCnt();
		int adec1 = alist.get(0).getADecideCnt();
		int adec2 = alist.get(1).getADecideCnt();
		
		model.addAttribute("dec", dec);
		model.addAttribute("dth", dth);
		model.addAttribute("adec1", adec1);
		model.addAttribute("adec2", adec2);
		model.addAttribute("alist", alist);
		
		return "/dailyAll/dashboard";
	}
	
	@GetMapping("/beta")
	public String beta(Model model) throws IOException {
		
		//service.Crawler();
		
		ArrayList<DisasterVO> dlist = service.DisasterMsg(service.getDisasterMsgApi());
		//System.out.println("DisasterMsg dlist: " + dlist);
		model.addAttribute("dlist", dlist);
				
		return "/dailyAll/beta";
	}
	
	@GetMapping("/testChart")
	public String gChart() {
		return "/dailyAll/testChart";
	}
	
}

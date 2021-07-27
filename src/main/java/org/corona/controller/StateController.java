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
	
	private StateService service;
	
	
	@GetMapping("/")
	public String test(Model model) throws IOException {
		
		//service.Crawler();

		String eDay = service.today();	// 기준일 (=종료일)
		String sDay = service.day(eDay);	// 기준일-10일 (=시작일)
		ArrayList<StateVO> slist = service.covidState(service.getCovidStateApi(sDay, eDay));
		ArrayList<StateVO> alist = service.aCovidState(slist);
		log.info("aCovidState alist: " + alist);
		model.addAttribute("alist", alist);
		
		return "/dailyAll/dashboard";
	}
	
	@GetMapping("/beta")
	public String beta(Model model) throws IOException {
		ArrayList<StateVO> list = service.aCovidState(service.covidState(service.getCovidStateApi(service.day(service.today()), service.today())));
		model.addAttribute("state", list.get(0).getADecideCnt());
		
		//service.Crawler();
		
		ArrayList<DisasterVO> dlist = service.DisasterMsg(service.getDisasterMsgApi());
		System.out.println("DisasterMsg dlist: " + dlist);
		if(dlist.size()==0) {
			model.addAttribute("n", "n");
		} else {
			model.addAttribute("dlist", dlist);
		}
		
		model.addAttribute("mCnt", service.msgCount(dlist));
				
		return "/dailyAll/beta";
	}
	
}

package org.corona.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.corona.domain.AGEVO;
import org.corona.domain.ASAVO;
import org.corona.service.asaService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping
public class AsaController {
	asaService asc;
	
	@GetMapping("/ASA/asa")
	public String areaList(Model model, RedirectAttributes rttr) throws Exception {
		
		// 현재 시간 구하는 식
		SimpleDateFormat tt = new SimpleDateFormat("HHmmss");
		Date thisTime2 = new Date();
		String thisTime = tt.format(thisTime2);
		
		int thisTime1 = Integer.parseInt(thisTime);
		
		if((thisTime1 - 120000) < 0) {
			// 어제 날짜 구하는 식
			SimpleDateFormat yD = new SimpleDateFormat("yyyyMMdd");
			Date yDate = new Date();
			yDate = new Date(yDate.getTime()+(1000*60*60*24*-1));
			
			// 어제 날짜의 데이터
			String startCreateDt = yD.format(yDate);
			String endCreateDt = yD.format(yDate);
			// 지역
			ArrayList<ASAVO> alist = asc.asarea(startCreateDt, endCreateDt);
			model.addAttribute("alist", alist);
			// 연령, 성별
			ArrayList<AGEVO> blist = asc.asaage(startCreateDt, endCreateDt);
			model.addAttribute("blist", blist);
			rttr.addFlashAttribute("blist", blist);
		} else {
			// 오늘 날짜 구하는 식
			SimpleDateFormat tD = new SimpleDateFormat("yyyyMMdd");
			Date time = new Date();
			
			// 오늘 날짜의 데이터
			String startCreateDt = tD.format(time);
			String endCreateDt = tD.format(time);
			// 지역
			ArrayList<ASAVO> alist = asc.asarea(startCreateDt, endCreateDt);
			model.addAttribute("alist", alist);
			// 연령, 성별
			ArrayList<AGEVO> blist = asc.asaage(startCreateDt, endCreateDt);
			model.addAttribute("blist", blist);
			rttr.addFlashAttribute("blist", blist);
		}
		
		
		return "/ASA/asa";
		
	}
	
//	@GetMapping("/ASA/age")
//	public String ageList(Model model) throws Exception {
//		
//		// 현재 시간 구하는 식
//		SimpleDateFormat tt = new SimpleDateFormat("HHmmss");
//		Date thisTime2 = new Date();
//		String thisTime = tt.format(thisTime2);
//		
//		int thisTime1 = Integer.parseInt(thisTime);
//		
//		if((thisTime1 - 120000) < 0) {
//			// 어제 날짜 구하는 식
//			SimpleDateFormat yD = new SimpleDateFormat("yyyyMMdd");
//			Date yDate = new Date();
//			yDate = new Date(yDate.getTime()+(1000*60*60*24*-1));
//			
//			// 어제 날짜의 데이터
//			String startCreateDt = yD.format(yDate);
//			String endCreateDt = yD.format(yDate);
//			
//			ArrayList<ASAVO> blist = asc.asarea(startCreateDt, endCreateDt);
//			model.addAttribute("blist", blist);
//		} else {
//			// 오늘 날짜 구하는 식
//			SimpleDateFormat tD = new SimpleDateFormat("yyyyMMdd");
//			Date time = new Date();
//			
//			// 오늘 날짜의 데이터
//			String startCreateDt = tD.format(time);
//			String endCreateDt = tD.format(time);
//			
//			ArrayList<ASAVO> blist = asc.asarea(startCreateDt, endCreateDt);
//			model.addAttribute("blist", blist);
//		}
//		
//		return "/ASA/asa";
//	}
}

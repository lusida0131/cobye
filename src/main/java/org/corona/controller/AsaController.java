package org.corona.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.corona.domain.ASAVO;
import org.corona.service.asaService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@RequestMapping
public class AsaController {
	asaService asc;
	
	@GetMapping("/ASA/asa")
	public String areaList(Model model) throws Exception {
		// 오늘 날짜 구하는 식
		SimpleDateFormat tD = new SimpleDateFormat("yyyyMMdd");
		Date time = new Date();
		
		// 어제 날짜 구하는 식
		SimpleDateFormat yD = new SimpleDateFormat("yyyyMMdd");
		Date yDate = new Date();
		yDate = new Date(yDate.getTime()+(1000*60*60*24*-1));
		
		// 오늘 날짜의 데이터
		String startCreateDt = tD.format(time);
		String endCreateDt = tD.format(time);
		
		// 어제 날짜의 데이터
//		String startCreateDt = yD.format(yDate);
//		String endCreateDt = yD.format(yDate);
		
		// 형변환
//		int startCreateDtXX = Integer.parseInt(startCreateDtX);
//		int endCreateDtXX = Integer.parseInt(endCreateDtX);
//		String startCreateDt = Integer.toString(startCreateDtXX);
//		String endCreateDt = Integer.toString(endCreateDtXX);
		
		ArrayList<ASAVO> alist = asc.asarea(startCreateDt, endCreateDt);
		model.addAttribute("alist", alist);
		
		return "/ASA/asa";
		/* 미친짓 */
/*		String startCreateDt;
		String endCreateDt;
		
		if((startCreateDt = tD.format(time)) != null && (endCreateDt = tD.format(time)) != null) {
			
			ArrayList<ASAVO> alist = asc.asarea(startCreateDt, endCreateDt);
			model.addAttribute("alist", alist);
			if(alist != null) {
				return "/ASA/asa";
			} else {
				startCreateDt = yD.format(yDate);
				endCreateDt = yD.format(yDate);
				ArrayList<ASAVO> alist1 = asc.asarea1(startCreateDt, endCreateDt);
				model.addAttribute("alist", alist1);
			}
		}
			if((alist = asc.asarea(startCreateDt, endCreateDt)) != null) {

			} else {
				
			}
			
		}
		return "/ASA/asa"; */
		
	}
}

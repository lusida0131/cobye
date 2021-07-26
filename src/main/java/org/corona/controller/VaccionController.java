package org.corona.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.corona.domain.vaccionVO;
import org.corona.service.VaccineService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@AllArgsConstructor
@RequestMapping
@Log4j
public class VaccionController {
	
	private VaccineService service;
	@GetMapping("/vaccine/vac")
	public String vac() {
		
		return "/vaccine/vac";
	}
	
	@GetMapping("/vaccine/vac2")
	public String vac2(HttpServletRequest request, Model model) throws IOException{
		String start = request.getParameter("from_place");
		log.info(start);
		
		ArrayList<vaccionVO> vlist =  service.vaccionApi(start);
		model.addAttribute("vlist", vlist);
		return "/vaccine/vac2";
	}
	
	@GetMapping("/vaccine/vacmap")
	public String vacmap(HttpServletRequest request, Model model, RedirectAttributes attr) throws IOException{
		
		 
		String orgZipaddr = request.getParameter("orgZipaddr");
		
		
		attr.addFlashAttribute("orgZipaddr", orgZipaddr);
		
		System.out.println("dddddddddddddddddd" + orgZipaddr);
		return "/vaccine/vacmap";
	}
}

package org.corona.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import java.io.IOException;
import java.io.PrintWriter;
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
	
	@GetMapping("/vaccine/asd")
	public String asd() {
		return "/vaccine/asd";
	}
	@GetMapping("/vaccine/vac2")
	public String vac2(HttpServletRequest request,HttpServletResponse response ,Model model) throws IOException{
		String start = request.getParameter("from_place");
		String doo = request.getParameter("vapdo");
		String dog = request.getParameter("vapdog");
		log.info(start);
		ArrayList<vaccionVO> vlist =  service.vaccionApi(start, doo, dog);
		
		if (vlist.isEmpty()) { // api 조회 결과가 없을 때 = 항공편 미존재
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('해당 검색결과가 없습니다.'); </script>");
	        out.flush();
			
			return "/vaccine/vac";
		}
		model.addAttribute("start", start);
		model.addAttribute("doo", doo);
		model.addAttribute("vlist", vlist);
		return "/vaccine/vac2";
		
		}
	
	
	@GetMapping("/vaccine/vacmap")
	public String vacmap(HttpServletRequest request, Model model, RedirectAttributes attr) throws IOException{
		String orgZipaddr = request.getParameter("orgZipaddr");
		String orgnm = request.getParameter("orgnm");
		
		
		attr.addFlashAttribute("orgZipaddr", orgZipaddr);
		attr.addFlashAttribute("orgZipaddr", orgnm);
		System.out.println("dddddddddddddddddd" + orgZipaddr);
		System.out.println("ddddddddddddddssssssssss" + orgnm);
		return "/vaccine/vacmap";
		}
	

	
}

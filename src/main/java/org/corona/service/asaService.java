package org.corona.service;

import java.util.ArrayList;

import org.corona.domain.ASAVO;

public interface asaService {
	
	public ArrayList<ASAVO> asarea(String startCreateDt, String endCreateDt) throws Exception;
	
//	public ArrayList<ASAVO> asarea1(String startCreateDt, String endCreateDt) throws Exception;
}

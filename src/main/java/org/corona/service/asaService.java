package org.corona.service;

import java.util.ArrayList;

import org.corona.domain.AGEVO;
import org.corona.domain.ASAVO;

public interface asaService {
	// 지역
	public ArrayList<ASAVO> asarea(String startCreateDt, String endCreateDt) throws Exception;
	
	// 연령, 성별
	public ArrayList<AGEVO> asaage(String startCreateDt, String endCreateDt) throws Exception;
	
}

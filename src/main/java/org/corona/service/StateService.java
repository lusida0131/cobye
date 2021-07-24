package org.corona.service;

import java.io.IOException;
import java.util.ArrayList;

import org.corona.domain.StateVO;

public interface StateService {
	
	// today date get
	public String today();
	
	// date - 10
	public String day(String sDay);
	
	// api
	public String getCovidStateApi(String sDay, String eDay) throws IOException;
	
	// api
	public ArrayList<StateVO> covidState(String result);
	
	public ArrayList<StateVO> aCovidState(ArrayList<StateVO> list);
	
}

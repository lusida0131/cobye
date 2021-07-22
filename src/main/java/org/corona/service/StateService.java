package org.corona.service;

import java.io.IOException;

public interface StateService {
	
	// today date get
	public String today();
	
	// date - 10
	public String day(String sDay);
	
	// api
	public String getCovidStateApi(String sDay, String eDay) throws IOException;
	
	// api
	public String covidState(String result);
	
}

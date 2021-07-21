package org.corona.service;

import java.io.IOException;

public interface StateService {
	
	public String today();
	
	public String day(String sDay);
	
	public void getCovidStateApi(String sDay, String eDay) throws IOException;
	
}

package org.corona.service;

import java.io.IOException;
import java.util.ArrayList;

import org.corona.domain.DisasterVO;
import org.corona.domain.StateVO;

public interface StateService {
	
	// today date get
	public String today();
	// date - 10
	public String day(String sDay);
	
	// corona 현황 api 요청
	public String getCovidStateApi(String sDay, String eDay) throws IOException;
	// corona 현황 api 응답 데이터
	public ArrayList<StateVO> covidState(String result);
	// 일자별 변화량 추가
	public ArrayList<StateVO> aCovidState(ArrayList<StateVO> list);
	
	// Jsoup html parse
	public void Crawler();
	
	// 재난문자 현황 api 요청
	public String getDisasterMsgApi() throws IOException;
	// 재난문자 현황 api 응답 데이터
	public ArrayList<DisasterVO> DisasterMsg(String result);
	// 확진자 카운트
	public int msgCount(ArrayList<DisasterVO> list);
	
}

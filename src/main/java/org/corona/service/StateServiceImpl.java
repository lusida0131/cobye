package org.corona.service;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.corona.domain.StateVO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import lombok.AllArgsConstructor;



@Service
@AllArgsConstructor
public class StateServiceImpl implements StateService {

	@Override
	public String today() {
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String today = fmt.format(date);
		
		return today;
	}
	
	@Override
	public String day(String sDay) {
		
		Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
        cal.add(Calendar.DATE, -10);
        String day = fmt.format(cal.getTime());
        
		return day;
	}
	
	@Override
	public String getCovidStateApi(String sDay, String eDay) throws IOException {
		
		StringBuilder urlBuilder = new StringBuilder("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson"); // URL
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=A04I%2FDZd%2FTh0VEDOtCHizLhisxQeu9JTtTshqLMp9wJYwCF0wAAbOC5MpN%2BGwGuessW1Z%2FqgzaVdEgJCuPqodw%3D%3D"); // Service Key
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); // 공공데이터포털에서 받은 인증키
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 페이지번호
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); // 한 페이지 결과 수
        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(sDay, "UTF-8")); // 검색할 생성일 범위의 시작
        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(eDay, "UTF-8")); // 검색할 생성일 범위의 종료
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); // json type return
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("getCovidStateApi Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        
        String result = sb.toString();
        
		return result;
	}

	@Override
	public ArrayList<StateVO> covidState(String result) {
		
		ArrayList<StateVO> list = new ArrayList<StateVO>();
		
		JSONObject jObject = new JSONObject(result);
		JSONObject responseObject = jObject.getJSONObject("response");
		// response-header-> resultCode,resultMsg
		JSONObject headerObject = responseObject.getJSONObject("header");
	    String resultCode = headerObject.getString("resultCode");
	    String resultMsg = headerObject.getString("resultMsg");
		// response-body-> items, numOfRows, pageNo, totalCount
	    JSONObject bodyObject = responseObject.getJSONObject("body");
	    String numOfRows = Integer.toString(bodyObject.getInt("numOfRows"));
	    String pageNo = Integer.toString(bodyObject.getInt("pageNo"));
	    String totalCount = Integer.toString(bodyObject.getInt("totalCount"));
	    System.out.println("covidState totalCount: " + totalCount);
		// items-item
	    JSONObject itemsObject = bodyObject.getJSONObject("items");
	    JSONArray itemArray = itemsObject.getJSONArray("item");
	    
	    for (int i = 0; i < itemArray.length(); i++) {
	    	
	    	StateVO svo = new StateVO();
	    	
	    	JSONObject iobj = itemArray.getJSONObject(i);
	    	//System.out.println("iobj(" + i + "): " + iobj.toString());
	        
	    	// 게시글번호
	        svo.setSeq(iobj.getInt("seq"));
	        // 기준일
	        svo.setStateDt(String.valueOf(iobj.getInt("stateDt")));
	    	// 기준시간
	    	svo.setStateTime(iobj.getString("stateTime"));
	        // 확진자수
	        svo.setDecideCnt(iobj.getInt("decideCnt"));
	        svo.setADecideCnt(iobj.getInt("decideCnt"));
	        // 격리해제수
	        svo.setClearCnt(iobj.getInt("clearCnt"));
	        // 검사진행수
	        svo.setExamCnt(iobj.getInt("examCnt"));
	        // 사망자수
	        svo.setDeathCnt(iobj.getInt("deathCnt"));
	        svo.setADeathCnt(iobj.getInt("deathCnt"));
	        // 치료중환자수
	        svo.setCareCnt(iobj.getInt("careCnt"));
	        svo.setACareCnt(iobj.getInt("careCnt"));
	        // 결과음성수
	        svo.setResutlNegCnt(iobj.getInt("resutlNegCnt"));
	        // 누적검사수
	        svo.setAccExamCnt(iobj.getInt("accExamCnt"));
	        // 누적검사완료수
	        svo.setAccExamCompCnt(iobj.getInt("accExamCompCnt"));
	        // 누적확진률
	        svo.setAccDefRate(iobj.getFloat("accDefRate"));
	        // 등록시간
	        svo.setCreateDt(iobj.getString("createDt"));
	        // 수정시간
	        //svo.setUpdateDt(iobj.getString("updateDt"));
	        
	        //System.out.println((i+1) + "번째 item: " + svo);
	        list.add(svo);
	        
	    }
		return list;
	}
	
	@Override
	public ArrayList<StateVO> aCovidState(ArrayList<StateVO> list) {
		List<StateVO> dayList = new ArrayList<StateVO>();
		dayList = list.subList(1, list.size());
		
		for(int i = 0; i < list.size()-1; i++) {
			list.get(i).setADecideCnt(list.get(i).getDecideCnt() - dayList.get(i).getDecideCnt());
			list.get(i).setACareCnt(list.get(i).getCareCnt() - dayList.get(i).getCareCnt());
			list.get(i).setADeathCnt(list.get(i).getDeathCnt() - dayList.get(i).getDeathCnt());
		}
		
		list.remove(list.size()-1);
		
		return list;
	}


}

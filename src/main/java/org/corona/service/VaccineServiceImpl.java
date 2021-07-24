package org.corona.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.corona.domain.vaccionVO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import com.google.gson.JsonObject;

import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class VaccineServiceImpl implements VaccineService{

	@Override
	public ArrayList<vaccionVO> vaccionApi(String start)throws IOException {
		
		ArrayList<vaccionVO> list = new ArrayList<vaccionVO>();
		
		// URL
				StringBuilder urlBuilder = new StringBuilder("https://api.odcloud.kr/api/apnmOrg/v1/list");
			
				urlBuilder.append("?" + URLEncoder.encode("page","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
				
				urlBuilder.append("&" + URLEncoder.encode("perPage","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
				
			
			
				urlBuilder.append("&" + URLEncoder.encode("cond[orgZipaddr::LIKE]","UTF-8") + "=" + URLEncoder.encode(start, "UTF-8"));
		
				urlBuilder.append("&" + URLEncoder.encode("serviceKey","UTF-8") + "=E7TR7GkGB3YlWwOR8BSGYwtixVpS2cWRFjy4QGwrUCYwfQDoxoiNyg8jBvpJaBL4li1G1zDarq9S%2BZpgqa8KZg%3D%3D");
				
				
				 
			    
			    URL url = new URL(urlBuilder.toString());
			     HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			    conn.setRequestMethod("GET");
			    conn.setRequestProperty("Content-type", "application/json");
			    System.out.println("api URL Response code: " + conn.getResponseCode());
			    
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
			   
			 
			
			    String jsonString = sb.toString();
			    // 가장 큰 JSONObject를 가져옵니다.
			    JSONObject jObject = new JSONObject(jsonString);
			    System.out.println("jobject" + jObject);
			    // (response)  0번째 JSONObject를 가져옵니다.
//			    JSONArray dataObject = jObject.getJSONArray("data");
//
//			    System.out.println("DdDD" + dataObject);
//			    // (response -> header)  1번째 JSONObject를 가져와서 key-value를 읽습니다.
//			    JSONArray headerObject = dataObject.getString("orgnm");
//			    String resultCode = headerObject.getString("resultCode");
//			    String resultMsg = headerObject.getString("resultMsg");
//			    System.out.println("(header)resultCode: " + resultCode);
//			    System.out.println("(header)resultMsg: " + resultMsg);
//			    
//			    // (response -> body)  두번째 JSONObject를 가져와서 key-value를 읽습니다.
//			    JSONObject bodyObject = dataObject.getString("body");
			    
		
			    
//			    JSONObject itemsObject = bodyObject.getJSONObject("items");
			    
			    // (response -> body -> items -> item(node 2개이상))  세번째 JSONObject를 가져와서 key-value를 읽습니다.
			    JSONArray itemArray = jObject.getJSONArray("data");
			    for (int i = 0; i < itemArray.length(); i++) {
			    	
			    	vaccionVO svo = new vaccionVO();
			    	JSONObject iobj = itemArray.getJSONObject(i);
			     svo.setOrgcd(iobj.getString("orgcd"));
			     svo.setOrgnm(iobj.getString("orgnm"));
                 svo.setOrgZipaddr(iobj.getString("orgZipaddr"));
                 svo.setSlrYmd(iobj.getString("slrYmd"));
                 svo.setDywk(iobj.getString("dywk"));
                 svo.setHldyYn(iobj.getString("hldyYn"));
                 svo.setOrgTlno(iobj.getString("orgTlno"));
//                 svo.setLunchSttTm(iobj.getString("lunchSttTm"));
//                 svo.setLunchEndTm(String.valueOf(iobj.getInt("lunchEndTm")));
                 list.add(svo);
			        System.out.println("lossssssssssssssssssssssssss" + svo);
		    } 
			    
			    return list;
			}


			

}

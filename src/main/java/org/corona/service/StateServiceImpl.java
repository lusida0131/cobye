package org.corona.service;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.corona.domain.DisasterVO;
import org.corona.domain.StateVO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import lombok.AllArgsConstructor;



@Service
@AllArgsConstructor
public class StateServiceImpl implements StateService {

	@Override
	public String today() {
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat fmtTime = new SimpleDateFormat("HHmm");
		Calendar date = Calendar.getInstance();
		String today = fmt.format(date.getTime());
		int time = Integer.parseInt(fmtTime.format(date.getTime()));
		
		if (time < 1000) {
			date.setTime(new Date());
			date.add(Calendar.DATE, -1);
			today = fmt.format(date.getTime());
		}
		
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
		
		StringBuilder urlBuilder = new StringBuilder("http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson");	// URL
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=A04I%2FDZd%2FTh0VEDOtCHizLhisxQeu9JTtTshqLMp9wJYwCF0wAAbOC5MpN%2BGwGuessW1Z%2FqgzaVdEgJCuPqodw%3D%3D"); // Service Key
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8"));						// ??????????????????????????? ?????? ?????????
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));							// ???????????????
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));						// ??? ????????? ?????? ???
        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(sDay, "UTF-8"));					// ????????? ????????? ????????? ??????
        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(eDay, "UTF-8"));						// ????????? ????????? ????????? ??????
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));							// json type return
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("CovidStateApi Response code: " + conn.getResponseCode());
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
        
		return sb.toString();
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
		// items-item
	    JSONObject itemsObject = bodyObject.getJSONObject("items");
	    JSONArray itemArray = itemsObject.getJSONArray("item");
	    
	    for (int i = 0; i < itemArray.length(); i++) {
	    	StateVO svo = new StateVO();
	    	JSONObject iobj = itemArray.getJSONObject(i);
	    	
	        svo.setSeq(iobj.getInt("seq"));								// ???????????????
	        svo.setStateDt(String.valueOf(iobj.getInt("stateDt")));		// ?????????
	    	svo.setStateTime(iobj.getString("stateTime"));				// ????????????
	        svo.setDecideCnt(iobj.getInt("decideCnt"));					// ????????????
	        svo.setADecideCnt(iobj.getInt("decideCnt"));
	        svo.setClearCnt(iobj.getInt("clearCnt"));					// ???????????????
	        svo.setExamCnt(iobj.getInt("examCnt"));						// ???????????????
	        svo.setDeathCnt(iobj.getInt("deathCnt"));					// ????????????
	        svo.setADeathCnt(iobj.getInt("deathCnt"));
	        svo.setCareCnt(iobj.getInt("careCnt"));						// ??????????????????
	        svo.setACareCnt(iobj.getInt("careCnt"));
	        svo.setResutlNegCnt(iobj.getInt("resutlNegCnt"));			// ???????????????
	        svo.setAccExamCnt(iobj.getInt("accExamCnt"));				// ???????????????
	        svo.setAccExamCompCnt(iobj.getInt("accExamCompCnt"));		// ?????????????????????
	        svo.setAccDefRate(iobj.getFloat("accDefRate"));				// ???????????????
	        svo.setCreateDt(iobj.getString("createDt"));				// ????????????
	        //svo.setUpdateDt(iobj.getString("updateDt"));				// ????????????
	        
	        //System.out.println((i+1) + "?????? item: " + svo);
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
			list.get(i).setStateDt(String.valueOf(Integer.parseInt(list.get(i).getStateDt())-1));
		}
		list.remove(list.size()-1);
		
		return list;
	}

	
	@Override
	public void Crawler() {
		// ?????? URL
		//String URL = "https://m.news.naver.com/covid19/live.nhn";
		//String URL = "https://corona-live.com/";
		String URL = "https://corona-live.com/city/0/";
		
		try {
            // Connection ??????
            Connection conn = Jsoup.connect(URL);
            // HTML ??????
            Document html = conn.get(); // conn.post();
            // HTML ??????
            System.out.println(html.toString()); 
            
            // Attribute ??????
//            Elements fileblocks = html.getElementsByClass("fileblock");
//            for( Element fileblock : fileblocks ) {
//                Elements files = fileblock.getElementsByTag("a");
//                for( Element elm : files ) {
//	                String text = elm.text();
//	                String href = elm.attr("href");
//	                System.out.println( text+" > "+href );
//                }
//            }
            // CSS Selector ??????
//            Elements files = html.select(".fileblock a");
//            for( Element elm : files ) {
//            	String text = elm.text();
//            	String href = elm.attr("href");
//            	System.out.println( text+" > "+href );
//            }
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	@Override
	public String getDisasterMsgApi() throws IOException {
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1741000/DisasterMsg3/getDisasterMsg1List");	// URL
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=A04I%2FDZd%2FTh0VEDOtCHizLhisxQeu9JTtTshqLMp9wJYwCF0wAAbOC5MpN%2BGwGuessW1Z%2FqgzaVdEgJCuPqodw%3D%3D"); // Service Key
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("?????????", "UTF-8"));		// ??????????????????????????? ?????? ?????????
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));				// ???????????????
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("150", "UTF-8"));			// ??? ????????? ?????? ???
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));				// ???????????? ??????
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("DisasterMsgApi Response code: " + conn.getResponseCode());
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
		
		return sb.toString();
	}

	@Override
	public ArrayList<DisasterVO> DisasterMsg(String result) {
		
		ArrayList<DisasterVO> list = new ArrayList<DisasterVO>();
		int count = 0;
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy/MM/dd");
		String today = fmt.format(Calendar.getInstance().getTime());
		
		Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -1);
        SimpleDateFormat yfmt = new SimpleDateFormat("dd");
        String yday = yfmt.format(cal.getTime());
		
		JSONObject jObject = new JSONObject(result);
		JSONArray DisasterArray = jObject.getJSONArray("DisasterMsg");
		// response - head -> list_total_count, RESULT		// RESULT -> CODE, MESSAGE
		// response - row -> create_date, location_id, location_name, md101_sn, msg, send_platform
		JSONObject rowObject = DisasterArray.getJSONObject(1);
		JSONArray rowArray = rowObject.getJSONArray("row");
	    
	    for (int i = 0; i < rowArray.length(); i++) {
	    	DisasterVO dvo = new DisasterVO();
	    	JSONObject iobj = rowArray.getJSONObject(i);
	    	
	    	if( iobj.getString("create_date").substring(0,10).equals(today) == false ) { continue; }
	    	if( iobj.getString("msg").contains("??????")==false || iobj.getString("msg").contains("???")==false ) { continue; }
	    	if( iobj.getString("msg").contains(" 0???")==true || iobj.getString("msg").contains("00???")==true
	    			|| iobj.getString("msg").contains("24???")==true || iobj.getString("msg").contains(yday)==true
	    			|| iobj.getString("location_name").contains("??????")==true ) { continue; }
	    	
	    	dvo.setCreate_date(iobj.getString("create_date"));		// ????????????
	    	dvo.setLocation_id(iobj.getString("location_id"));		// ???????????? ??????
	    	dvo.setLocation_name(iobj.getString("location_name"));	// ???????????? ??????
	    	dvo.setMd101_sn(iobj.getString("md101_sn"));			// ????????????
	    	dvo.setMsg(iobj.getString("msg"));						// ??????
	    	dvo.setSend_platform(iobj.getString("send_platform"));	// ?????????
	        
	        //System.out.println("(" + i + ") ?????? Disaster row: " + dvo);
	        list.add(dvo);
	        count++;
	    }
	    System.out.println("DisasterMsg count: " + count);
		return list;
	}

	@Override
	public int msgCount(ArrayList<DisasterVO> list) {
		
		int mCnt = 0;
		String[] keyword = { "^.*(??????.)(\\d{1,3})(???).*$","^.*(?????????)(\\d{1,3})(???.??????).*$","^.*(?????????)(\\d{1,3})(???).*$",
							 "^.*(??????.)(\\d{1,3})(???.????????????).*$","^.*(???????????????.)(\\d{1,3})(???.??????).*$","^.*(?????????.)(\\d{1,3})(???).*$",
							 "^.*(?????????.)(\\d{1,3})(???.??????).*$","^.*(?????????.??????.)(\\d{1,3})(???).*$","^.*(?????????19?????????.)(\\d{1,3})(???.??????).*$",
							 "^.*(?????????19.?????????.)(\\d{1,3})(???.??????).*$","^.*(?????????.)(\\d{1,3})(?????????).*$","^.*(??????.?????????.)(\\d{1,3})(???.??????).*$",
							 "^.*(?????????19.???????????????.)(\\d{1,3})(???.??????).*$","^.*(??????.)(\\d{1,3})(???).*$","^.*(???????????????.)(\\d{1,3})(???.??????).*$" };
        for(int i = 0; i < list.size(); i++){
        	for(int j = 0; j < keyword.length; j++) {
        		Pattern pattern = Pattern.compile(keyword[j]);
                Matcher matcher = pattern.matcher(list.get(i).getMsg());
                if (matcher.find()){
                	mCnt += Integer.parseInt(matcher.group(2));
                	//System.out.println("@@ find @@ >>>>>> " + matcher.group(2));
                	break;
                }
        	}
        }
		System.out.println("!!!!!!! result count : " + mCnt);
		return mCnt;
	}

}

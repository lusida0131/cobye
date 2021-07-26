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
//		System.out.println("int parse time: "+time);
		
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
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8"));						// 공공데이터포털에서 받은 인증키
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));							// 페이지번호
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));						// 한 페이지 결과 수
        urlBuilder.append("&" + URLEncoder.encode("startCreateDt","UTF-8") + "=" + URLEncoder.encode(sDay, "UTF-8"));					// 검색할 생성일 범위의 시작
        urlBuilder.append("&" + URLEncoder.encode("endCreateDt","UTF-8") + "=" + URLEncoder.encode(eDay, "UTF-8"));						// 검색할 생성일 범위의 종료
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));							// json type return
        
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
	    	
	        svo.setSeq(iobj.getInt("seq"));								// 게시글번호
	        svo.setStateDt(String.valueOf(iobj.getInt("stateDt")));		// 기준일
	    	svo.setStateTime(iobj.getString("stateTime"));				// 기준시간
	        svo.setDecideCnt(iobj.getInt("decideCnt"));					// 확진자수
	        svo.setADecideCnt(iobj.getInt("decideCnt"));
	        svo.setClearCnt(iobj.getInt("clearCnt"));					// 격리해제수
	        svo.setExamCnt(iobj.getInt("examCnt"));						// 검사진행수
	        svo.setDeathCnt(iobj.getInt("deathCnt"));					// 사망자수
	        svo.setADeathCnt(iobj.getInt("deathCnt"));
	        svo.setCareCnt(iobj.getInt("careCnt"));						// 치료중환자수
	        svo.setACareCnt(iobj.getInt("careCnt"));
	        svo.setResutlNegCnt(iobj.getInt("resutlNegCnt"));			// 결과음성수
	        svo.setAccExamCnt(iobj.getInt("accExamCnt"));				// 누적검사수
	        svo.setAccExamCompCnt(iobj.getInt("accExamCompCnt"));		// 누적검사완료수
	        svo.setAccDefRate(iobj.getFloat("accDefRate"));				// 누적확진률
	        svo.setCreateDt(iobj.getString("createDt"));				// 등록시간
	        //svo.setUpdateDt(iobj.getString("updateDt"));				// 수정시간
	        
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
			
			list.get(i).setStateDt(String.valueOf(Integer.parseInt(list.get(i).getStateDt())-1));
		}
		
		list.remove(list.size()-1);
		
		return list;
	}

	
	@Override
	public void Crawler() {
		// 대상 URL
		//String URL = "https://m.news.naver.com/covid19/live.nhn";
		//String URL = "https://corona-live.com/";
		String URL = "https://corona-live.com/city/0/";
		
		try {
            // Connection 생성
            Connection conn = Jsoup.connect(URL);
            // HTML 파싱
            Document html = conn.get(); // conn.post();
            // HTML 출력
            System.out.println(html.toString()); 
            
            // Attribute 탐색
//            Elements fileblocks = html.getElementsByClass("fileblock");
//            for( Element fileblock : fileblocks ) {
//                Elements files = fileblock.getElementsByTag("a");
//                for( Element elm : files ) {
//	                String text = elm.text();
//	                String href = elm.attr("href");
//	                System.out.println( text+" > "+href );
//                }
//            }
            // CSS Selector 탐색
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
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("인증키", "UTF-8"));		// 공공데이터포털에서 받은 인증키
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));				// 페이지번호
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("150", "UTF-8"));			// 한 페이지 결과 수
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));				// 호출문서 형식
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
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
	    	if( iobj.getString("msg").contains("확진")==false || iobj.getString("msg").contains("명")==false ) { continue; }
	    	if( iobj.getString("msg").contains(" 0시")==true || iobj.getString("msg").contains("00시")==true
	    			|| iobj.getString("msg").contains("24시")==true || iobj.getString("msg").contains(yday)==true
	    			|| iobj.getString("location_name").contains("전체")==true ) { continue; }
	    	
	    	dvo.setCreate_date(iobj.getString("create_date"));		// 생성일시
	    	dvo.setLocation_id(iobj.getString("location_id"));		// 수신지역 코드
	    	dvo.setLocation_name(iobj.getString("location_name"));	// 수신지역 이름
	    	dvo.setMd101_sn(iobj.getString("md101_sn"));			// 일련번호
	    	dvo.setMsg(iobj.getString("msg"));						// 내용
	    	dvo.setSend_platform(iobj.getString("send_platform"));	// 발신처
	        
	        //System.out.println("(" + i + ") 번째 Disaster row: " + dvo);
	        list.add(dvo);
	        count++;
	    }
	    System.out.println("DisasterMsg coutn: " + count);
		return list;
	}

	@Override
	public int msgCount(ArrayList<DisasterVO> list) {
		int mCnt = 0;
		String[] keyword = { "^.*(주민.)(\\d{1,3})(명).*$","^.*(확진자)(\\d{1,3})(명.발생).*$","^.*(확진자)(\\d{1,3})(명).*$",
							 "^.*(주민.)(\\d{1,3})(명.추가확진).*$","^.*(일일확진자.)(\\d{1,3})(명.발생).*$","^.*(확진자.)(\\d{1,3})(명).*$",
							 "^.*(확진자.)(\\d{1,3})(명.발생).*$","^.*(확진자.발생.)(\\d{1,3})(명).*$","^.*(코로나19확진자.)(\\d{1,3})(명.발생).*$",
							 "^.*(코로나19.확진자.)(\\d{1,3})(명.발생).*$","^.*(확진자.)(\\d{1,3})(명발생).*$","^.*(신규.확진자.)(\\d{1,3})(명.발생).*$",
							 "^.*(코로나19.신규확진자.)(\\d{1,3})(명.발생).*$","^.*(확진.)(\\d{1,3})(명).*$","^.*(신규확진자.)(\\d{1,3})(명.발생).*$" };
        String[] alist = { 
        		"[완도군청]오늘소안면 확진자 5명 발생.(기존13명, 추가5명)▶마스크 착용 등 방역수칙 준수. 의심증상이 있을 시 보건의료원에서 검사받으시기 바랍니다.","[남양주시청] 7.26.(월) 남양주시 주민 17명(타지역 거주 1명포함) 코로나19 확진. 방역사항은 홈페이지, 블로그 참고바랍니다. c11.kr/qub8","[의정부시청]7월 26일 18시 기준, 일일확진자 11명 발생(1902~1912번) 홈페이지 및 블로그 https://c11.kr/joao 참고 바랍니다.","[당진시청]7/26(월) 16시기준 확진자1명(관내 확진자 접촉1)발생. 총476명. ▲7/27(화)부터 거리두기 3단계 시행됩니다 vo.la/Tp5EU","[이천시청] 7월26일 확진자 5명 발생(동반입소중2, 확진자접촉2, 자가격리중1). 자세한 내용은 홈페이지(icheon.go.kr) 및 블로그 참조바랍니다.","[가평군청] 7월 26일 코로나19 일일 확진자 1명(232번, 관외거주자) 발생. 개인 방역수칙 철저 당부.","[평택시]확진자12명(관내6,관외1(오산1),조사중4,해외입국1(미얀마))발생.상세한사항평택시홈페이지를참고하세요☞ www.pyeongtaek.go.kr/route","[화성시청] 7월26일 18시 현재, 확진자 30명(화성 2087~2116번) 발생하였습니다. 상세내용은 hscity.go.kr/crn.do 참조","[논산시청] 7월26일 18시 기준 확진자 1명(논산 226번, 관내접촉)발생. 자세한 내용은 시청 홈페이지 및 SNS 참고바랍니다.","[밀양시청]7월26일(월)18시기준 코로나19 확진자 4명 발생(밀양155~158번 자가격리중 확진)마스크 착용등 방역수칙을 준수해 주시기 바랍니다.","[부천시청] 7월 26일(월) 18:00기준 코로나19확진자 19명 발생, 세부내용은 블로그 참조하시기 바랍니다 blog.naver.com/bucheon-city","[김포시청] 7월 26일 17시 기준, 코로나19 확진자 9명 발생/ 세부사항은 김포시 블로그를 참조하시기 바랍니다. vo.la/3ULTc","[김해시청] 7.26. (월) 확진자 22명 발생(김해1330~1351), 김해유흥관련1,관내확진자접촉10,관외확진자접촉3,격리중6,조사중2 / 역학조사및소독완료","[과천시청] 7월 26일(월) 17시 기준 신규 확진자 1명 발생. 상세내용은 시홈페이지 및 과천마당앱 등에서 참고하시기 바랍니다 www.gccity.go.kr","[양산시청] 7.26.(월) 17시 기준, 코로나19 확진자 3명 발생(격리해제전검사 1, 격리중 증상발생검사 1, 증상발생검사 1)","[구리시청]7.26.(월) 확진자 7명(격리중1,해외입국자1)발생. 구리시 관내 학원 및 실내체육시설 종사자 7.31까지 진단검사 실시 bit.ly/3BGo5mB","[광주시청]7월 26일 17시 기준 확진자 10명 발생. 기침, 발열 등 의심 증상 발현 시 가까운 선별진료소에서 검사받으세요.","[안산시청]7월26일17시기준 확진자 36명발생, 상세내용은 시홈페이지, 블로그 참조바랍니다. blog.naver.com/cityansan/222446082034","[구례군청] 7. 26.(월) 구례 확진자 1명 발생 구례군 이동동선 및 접촉자 파악 완료","[광명시청] 7월26일 12시 기준 확진자 11명 발생(확진자접촉2, 조사중9) 세부내용은 블로그 참조 바랍니다. blog.naver.com/gmcityhall","[계룡시청] 7월 26일 15시 기준 확진자 1명 발생(계룡39번, 타지역 확진자 접촉) 자가격리 중 확진으로 공개 동선은 없습니다.","[군포시청] 7월 26일 14시 기준 전일 대비 확진자 2명 발생, 상세내용은 군포시 홈페이지, SNS 등 참조바랍니다. pf.kakao.com/_eDSsxb","[시흥시청] 7월 26일 13시 기준 확진자 17명 발생(관내 16, 관외 1명) blog.naver.com/siheungblog/222446035974","[오산시청] 7월 26일 13시 기준 확진자 6명 발생. 자세한 내용은 pf.kakao.com/_ubxjxdxb 를 참조하시기 바랍니다.","[통영시청] 7월 26일 10시 기준 확진자 1명(통영 124번, 해외입국자)발생, 확진자 현황은 시홈페이지를 참고 하시기 바랍니다.","[서산시청] 7월 26일 11시 기준 확진자 4명 발생(398~401번 / 관내 접촉2, 해외입국자1, 조사 중1) ▲수도권 등 타지역 방문을 자제 바랍니다.","[문경시청]7월26일 문경시46번(예천확진자 접촉),47번(42,43번확진자 접촉) 확진자 2명 발생.이동동선 및 자세한 내용은 문경시청 홈페이지를 참고바랍니다.","[하남시청] 7/26(월) 10시 기준 신규 확진자 7명(관내 6명, 타지역 1명) 발생. 블로그 및 홈페이지 참고하시기 바랍니다. c11.kr/qtoo","[금산군청] 금산군 신규확진자 8명(격리중 확진 5명, 관내접촉 3명) 발생. 22~23일 제원소재 청풍명월 방문객은 선별진료소에서 검사 받으시기 바랍니다.","[함양군청] 7월26일(월) 코로나19 확진자 1명 발생(자가격리 중) ▲이동동선 및 접촉자 없음 ▲타지역 방문 및 모임 자제 ▲마스크 착용 등 방역수칙 준수","[수원시청] 7월 26일 10시 기준, 수원 확진자 22명 발생. 기침, 발열 등 의심증상 있으면 가까운 선별진료소에서 검사받으세요. me2.kr/yzpjg","[공주시청] 7월 26일 10시 기준 전일 확진자 3명 추가 발생. 공주173~175번(20대, 공주169번 관련). 자가격리 중 확진으로 이동동선 없습니다.","[세종시청]7월26일0시 기준, 전일 확진자 5명 발생(694~698). 확진자 관련(가족 3, 접촉 1), 조사중 1. 자세한 사항은 시홈페이지 참고 바랍니다.","[함안군청] 7월 26일 확진자 1명(함안107, 자가격리 중) 발생, 마스크착용 등 방역수칙 준수 바랍니다.","[김제시청] 7.26.(월) 09시기준. 확진자 10명 발생, 김제188~197번(외국인 집단발생 관련) 의심증상시 선별진료소에서 검사받으시기 바랍니다.","[보령시청]7월26일(월) 09:00기준 보령시 신규확진자 1명발생(보령시165,170,174번접촉자,자가격리중)자세한 사항은 VO.AL/ONM84 참고바랍니다."
        		};
		for(int i = 0; i < alist.length; i++){
        	for(int j = 0; j < keyword.length; j++) {
        		Pattern pattern = Pattern.compile(keyword[j]);
                Matcher matcher = pattern.matcher(alist[i]);
                if (matcher.find()){
                	mCnt += Integer.parseInt(matcher.group(2));
                	System.out.println("@@ find @@ >>>>>> " + matcher.group(2));
                	break;
                }
        	}
        }
		

//        for(int i = 0; i < list.size(); i++){
//        	for(int j = 0; j < keyword.length; j++) {
//        		Pattern pattern = Pattern.compile(keyword[j]);
//                Matcher matcher = pattern.matcher(list.get(i).getMsg());
//                if (matcher.find()){
//                	mCnt += Integer.parseInt(matcher.group(2));
//                	System.out.println("@@ find @@ >>>>>> " + matcher.group(2));
//                	break;
//                }
//        	}
//        }
        
//        boolean result = Pattern.matches(keyword[0], list[0]);
//        System.out.println("result: "+result);
//        Pattern pattern = Pattern.compile(keyword[0]);
//        Matcher matcher = pattern.matcher(list[0]);
//        if (matcher.find()){
//        	mCnt += Integer.parseInt(matcher.group(2));
//        	System.out.println(matcher.group(2));
//        }
		System.out.println("!!!!!!! result count : " + mCnt);
		return mCnt;
	}
	

}

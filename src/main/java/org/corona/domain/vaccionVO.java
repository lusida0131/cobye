package org.corona.domain;
import lombok.Data;

@Data
public class vaccionVO {
	String orgcd;	
	//기관코드

	String orgnm;	
	//기관명

	String orgTlno;	
	//기관전화번호

	String orgZipaddr;	
	//기관주소
	
	String start;
	// 주소
	String 	slrYmd;	
	//기준일자(현재날짜)

	String dywk;	
	//기준일자 요일

	String 	hldyYn;	
	//기준일자 휴무일여부

	String 	lunchSttTm;
	//기준일자 점심시작시간

	String 	lunchEndTm;
	//기준일자 점심종료시간

	String 	sttTm;
	//기준일자 진료시작시간

	String 	endTm;
	//기준일자 진료종료시간
}

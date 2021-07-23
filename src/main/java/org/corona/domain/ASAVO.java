package org.corona.domain;

import lombok.Data;

@Data
public class ASAVO {
	// 지역
	String stdDay; 		//기준일시
	String createDt;	//등록일시
	int deathCnt;		//사망자 수
	int incDec;		//전일대비 증감 수
	String gubun;		//시도명
	int isolIngCnt;		//격리중인 환자 수
	int isolClearCnt;	//격리해제 수
	int defCnt;		//확진자 수
	int overFlowCnt;	//해외유입 수
	int localOccCnt;	//지역발생 수
}

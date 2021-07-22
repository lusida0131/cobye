package org.corona.domain;

import lombok.Data;

@Data
public class StateVO {

	int aDecideCnt;		// 확진자
	int aCareCnt;		// 치료환자
	int aDeathCnt;		// 사망자
	
	
	int seq;			// 게시글번호(감염현황 고유값)
	String stateDt;		// 기준일
	String stateTime;	// 기준시간
	int decideCnt;		// 확진자 수
	int clearCnt;		// 격리해제 수
	int examCnt;		// 검사진행 수
	int deathCnt;		// 사망자 수
	int careCnt;		// 치료중 환자 수
	int resutlNegCnt;	// 결과 음성 수
	int accExamCnt;		// 누적 검사 수
	int accExamCompCnt;	// 누적 검사 완료 수
	float accDefRate;	// 누적 확진률
	String createDt;	// 등록일시분초
	//String updateDt;	// 수정일시분초

}

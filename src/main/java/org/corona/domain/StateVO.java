package org.corona.domain;

import java.sql.Date;
import java.sql.Time;

import lombok.Data;

@Data
public class StateVO {
	
	int SEQ;				// 게시글번호(감염현황 고유값)
	String STATE_DT;		// 기준일
	Time STATE_TIME;		// 기준시간
	int DECIDE_CNT;			// 확진자 수
	int CLEAR_CNT;			// 격리해제 수
	int EXAM_CNT;			// 검사진행 수
	int DEATH_CNT;			// 사망자 수
	int CARE_CNT;			// 치료중 환자 수
	int RESUTL_NEG_CNT;		// 결과 음성 수
	int ACC_EXAM_CNT;		// 누적 검사 수
	int ACC_EXAM_COMP_CNT;	// 누적 검사 완료 수
	float ACC_DEF_RATE;		// 누적 확진률
	Date CREATE_DT;			// 등록일시분초
	Date UPDATE_DT;			// 수정일시분초
	
}

package org.corona.domain;

import lombok.Data;

@Data
public class ASAVO {
	String CREATE_DT;	//등록일시
	int DEATH_CHT;		//사망자 수
	int INC_DEC;		//전일대비 증감 수
	String GUBUN;		//시도명
	int ISOL_CLEAR_CNT;	//격리해제 수
	int DEF_CNT;		//확진자 수
	int OVER_FLOW_CNT;	//해외유입 수
	int LOCAL_OCC_CNT;	//지역발생 수
}

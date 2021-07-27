package org.corona.domain;

import lombok.Data;

@Data
public class DisasterVO {

	private String create_date;		// 생성일시
	private String location_id;		// 수신지역 코드
	private String location_name;	// 수신지역 이름
	private String md101_sn;		// 일련번호
	private String msg;				// 내용
	private String send_platform;	// 발신처

}

package org.corona.domain;

import lombok.Data;

@Data
public class AGEVO {
	String gubun;		// 연령, 성별
	int confCase;		// 확진자
	int confCaseRate;	// 확진률
	int death;			// 사망자
	float deathRate;		// 사망률
}

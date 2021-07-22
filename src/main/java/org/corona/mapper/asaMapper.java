package org.corona.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.corona.domain.ASAVO;


@Mapper
public interface asaMapper {

	// 지역 리스트
	public ArrayList<ASAVO> asarea() throws Exception;
}

package org.corona.service;

import java.io.IOException;
import java.util.ArrayList;

import org.corona.domain.vaccionVO;


public interface VaccineService {

	ArrayList<vaccionVO> vaccionApi(String start, String doo,String dog) throws IOException;



}

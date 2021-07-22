package org.corona.service;

import java.io.IOException;
import java.util.ArrayList;
import org.corona.controller.vaccionVO;


public interface VaccineService {

	ArrayList<vaccionVO> vaccionApi(String start) throws IOException;

}

package com.spring.naonnaTest.ground;

import java.util.ArrayList;

public interface GroundService {
	
	ArrayList<GroundVO> getGroundJson();
	ArrayList<GroundVO> Ground_DAO_Json(GroundVO vo);
	ArrayList<GroundVO> Ground_Time_Json(GroundVO groundvo, BookingVO bookingvo);
	
}

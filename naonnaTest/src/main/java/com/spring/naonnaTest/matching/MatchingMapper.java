package com.spring.naonnaTest.matching;

import java.util.ArrayList;

public interface MatchingMapper {

	ArrayList<MatchingVO> getMatchingList();
	ArrayList<MatchingVO> searchMatchingList(MatchingVO vo);
	void insertMatching(MatchingVO vo);
	MatchingVO detailMatching(String matchingID);
	void matchFin(String matchingID);
}

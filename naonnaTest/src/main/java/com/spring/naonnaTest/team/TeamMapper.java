package com.spring.naonnaTest.team;

import java.util.ArrayList;

public interface TeamMapper {
	
	public ArrayList<TeamVO> getTeamlist(TeamVO teamvo);  // 팀 목록 가져오기 
	public ArrayList<TeamVO> findTeam(TeamVO teamvo);
	
	

}

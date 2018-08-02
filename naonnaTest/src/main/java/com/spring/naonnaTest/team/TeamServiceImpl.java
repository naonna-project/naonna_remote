package com.spring.naonnaTest.team;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("teamService")
public class TeamServiceImpl implements TeamService {

	@Autowired
	private SqlSession sqlSession;	

	@Override
	public ArrayList<TeamVO> getTeamlistJson(TeamVO teamvo){
		ArrayList<TeamVO> teamlist = null;
		TeamMapper teamMapper = sqlSession.getMapper(TeamMapper.class);
		teamlist = teamMapper.getTeamlist(teamvo);
		
		return teamlist;
	}
	
	@Override
	public ArrayList<TeamVO> getTeamfindson(TeamVO teamvo) {
		ArrayList<TeamVO> teamlist = null;
		try {
			TeamMapper teamMapper = sqlSession.getMapper(TeamMapper.class);
			teamlist = teamMapper.findTeam(teamvo);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return teamlist;
		
	}
	

}

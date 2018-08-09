package com.spring.naonnaTest.ground;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("groundService")
public class GroundServiceImpl implements GroundService{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired(required=false) 		//@Autowired는 필드 생성자 메소드에 사용 가능
	private GroundDAO groundDAO = null;		//new UserDAO()객체가 자동으로 생성되어서 대입된다.
	
	@Override
	public ArrayList<GroundVO> getGroundJson() {
		ArrayList<GroundVO> groundList = null;
		GroundMapper groundMapper = sqlSession.getMapper(GroundMapper.class);
		groundList = groundMapper.getGroundList();
		
		return groundList;
	}
	
	@Override
	public ArrayList<GroundVO> Ground_DAO_Json(GroundVO vo) {
		ArrayList<GroundVO> groundList = groundDAO.DAOtoMapper(vo);
		return groundList;
	}
	
	@Override
	public ArrayList<GroundVO> Ground_Time_Json(GroundVO groundvo, BookingVO bookingvo) {
		ArrayList<GroundVO> groundList = groundDAO.TimetoMapper(groundvo, bookingvo);
		return groundList;
	}
	
	/*@Override
	public ArrayList<GroundVO> That_Ground_Info_JSON(GroundVO vo){
		ArrayList<GroundVO> getThatGroundList = null;
		GroundMapper groundMapper = sqlSession.getMapper(GroundMapper.class);
		getThatGroundList = groundMapper.getGroundList();
		
		return getThatGroundList;
		
	}*/
	
	@Override
	public GroundVO That_Ground_Info(String Ground_Name){
		GroundVO ThatGroundInfo = new GroundVO();
		GroundMapper groundMapper = sqlSession.getMapper(GroundMapper.class);
		ThatGroundInfo = groundMapper.getThatGroundList(Ground_Name);
		
		return ThatGroundInfo;
	}
	
	@Override
	public void insertGround(GroundVO vo) {
		GroundMapper groundMapper = sqlSession.getMapper(GroundMapper.class);
		try {
			int res = groundMapper.insertGround(vo);		//삽입 후 삽인한 결과 상태 반환하기 위해 반환값을 int로 줌
			System.out.println("res = " + res);
		}
		catch(Exception e) {
			e.printStackTrace();
			e.getMessage();
			
		}
		//return res;
		
		
	}
	
/*	@Override
	public void insertGround2(HashMap<String, String> map) {
		System.out.println("hashmap");
		GroundMapper groundMapper = sqlSession.getMapper(GroundMapper.class);
		groundMapper.insertGround2(map);
		
	}
	*/
}

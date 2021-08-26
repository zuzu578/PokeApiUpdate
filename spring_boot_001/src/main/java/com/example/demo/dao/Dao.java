package com.example.demo.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.Dto.BoardDto;

@Repository
public class Dao {
	protected static final String NAMESPACE = "com.example.demo.dao.";

	@Autowired
	private SqlSession sqlSession;
	public List<Map<String, Object>> getBoardList() {
		
		return sqlSession.selectList(NAMESPACE + "getBoardList");
	}
	public String selectName(){
		return sqlSession.selectOne(NAMESPACE + "selectName");
	}
	public void fileUpload(String f) {
		sqlSession.insert("com.example.demo.dao.fileUpload",f);
		
	}
	
	public void create(HashMap<String, Object> data) {
		sqlSession.insert("com.example.demo.dao.create",data);
		
	}


	
}

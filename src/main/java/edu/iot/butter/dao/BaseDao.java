package edu.iot.butter.dao;

import java.util.List;
import java.util.Map;

public interface BaseDao<M, K> {	//Memberdao와 ImageDao의 모델 객체와 매개변수 타입이 다름
	
	int getCount() throws Exception;

	List<M> selectList(Map map) throws Exception;

	M selectOne(K k) throws Exception;

	int insert(M m) throws Exception;

	int update(M m) throws Exception;

	int delete(K k) throws Exception;
}

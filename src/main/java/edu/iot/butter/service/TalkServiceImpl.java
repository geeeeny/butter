package edu.iot.butter.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.iot.butter.dao.TalkDao;
import edu.iot.butter.model.Talk;

@Service
public class TalkServiceImpl implements TalkService {

	@Autowired
	TalkDao dao;
	
	@Override
	public List<Talk> getTalkList(Talk talk) throws Exception {
		System.out.println(talk);
		return dao.selectList(talk);
	}

	@Override
	public Talk getTalk(int talkId) throws Exception {
		return dao.selectOne(talkId);
	}

	@Override
	public boolean create(Talk talk) throws Exception {
		return dao.insert(talk)==1;
	}

	@Override
	public boolean send(Talk talk) throws Exception {
		return dao.insert(talk)==1;
	}

	@Override
	public boolean delete(int talkId) throws Exception {
		return dao.delete(talkId)==1;
	}
	@Override
	public List<Talk> getNewTalks(String userId) throws Exception {
		return dao.getNewTalks(userId);
	}

	@Override
	public boolean updateCheck(Talk talk) throws Exception {
		return dao.updateCheck(talk)>0;
	}

}

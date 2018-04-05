package edu.iot.butter.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.iot.butter.dao.MemberDao;
import edu.iot.butter.model.Login;
import edu.iot.butter.model.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;
	
	
	@Override
	public Member checkLogin(Login login) throws Exception {

		Member member = dao.selectOne(login.getUserId());

		//아이디 존재하고 비밀번호도 일치
		if(member != null && member.getPassword().equals(login.getPassword())) {
			return member;
		}

		return null;
	}
	@Override
	public boolean checkId(String userId)throws Exception{
		Member member = dao.selectOne(userId);
		return member != null;
	}

	@Transactional
	@Override
	public boolean create(Member member) throws Exception{
		int result = dao.insert(member);
		return result == 1;
	}

}

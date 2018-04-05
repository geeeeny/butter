package edu.iot.butter.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.iot.butter.dao.MemberDao;
import edu.iot.butter.model.Login;
import edu.iot.butter.model.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;
	
	
	@Override
	public Member checkLogin(Login login) {
		try {
			Member m = dao.selectOne(login.getUserId());
			if(m==null) {	//userId가 없음
				return null;
			}
			if(!m.getPassword().equals(login.getPassword())) {	//비밀번호 틀림
				return null;
			}
			return m;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	@Override
	public void add(Member member) {
		try {
			dao.insert(member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

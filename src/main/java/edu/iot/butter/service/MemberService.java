package edu.iot.butter.service;

import edu.iot.butter.model.Login;
import edu.iot.butter.model.Member;
import edu.iot.butter.model.Password;

public interface MemberService {
	Member checkLogin(Login login) throws Exception;
	boolean checkId(String userId) throws Exception;
	boolean create(Member member) throws Exception;
	boolean update(Member member) throws Exception;
	Member getMember(String userId) throws Exception;
	boolean changePassword(Password password) throws Exception;
}

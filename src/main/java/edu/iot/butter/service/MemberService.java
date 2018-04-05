package edu.iot.butter.service;

import edu.iot.butter.model.Login;
import edu.iot.butter.model.Member;

public interface MemberService {
	Member checkLogin(Login login);
}

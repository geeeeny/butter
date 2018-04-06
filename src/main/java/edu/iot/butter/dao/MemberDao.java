package edu.iot.butter.dao;

import edu.iot.butter.model.Member;
import edu.iot.butter.model.Password;

public interface MemberDao extends BaseDao<Member, String>{	//인터페이스를 상속받음
	int changePassword(Password password);
}

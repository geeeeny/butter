package edu.iot.butter.model;

import java.util.Date;
import org.hibernate.validator.constraints.NotEmpty;
import lombok.Data;

@Data
public class Member {
	@NotEmpty(message="아이디를 입력하세요.")
	private String userId;
	
	@NotEmpty(message="이름을 입력하세요.")
	private String name;
	
	@NotEmpty(message="비밀번호를 입력하세요.")
	private String password;
	
	@NotEmpty(message="전화번호를 입력하세요.")
	private String cellPhone;

	private String email;
	private String address;
	private int grade;
	private int newMessages; //신규 메시지 개수
	private Date regDate;
	private Date updateDate;

}

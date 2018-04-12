package edu.iot.butter.model;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class Login {
	@NotEmpty(message="아이디를 입력하세요.")
	private String userId;
	
	@NotEmpty(message="비밀번호를 입력하세요.")
	private String password;
	
	private String url;
}

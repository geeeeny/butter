package edu.iot.butter.model;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class Password {
	@NotEmpty(message="사용자 ID를 입력해주세요.")
	private String userId;
	
	@NotEmpty(message="기존의 비밀번호를 입력해주세요.")
	private String oldPassword;
	
	@NotEmpty(message="새로운 비밀번호를 입력해주세요.")
	private String newPassword;
}

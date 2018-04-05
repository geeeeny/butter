package edu.iot.butter.model;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class Login {
	@NotEmpty
	private String userId;
	
	@NotEmpty
	private String password;
}

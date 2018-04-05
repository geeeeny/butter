package edu.iot.butter.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.iot.butter.model.Login;
import edu.iot.butter.model.Member;
import edu.iot.butter.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AccountController {
	@Autowired
	MemberService service;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginForm(Login login) {
		return "account/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginSubmit(@Valid Login login, BindingResult result) {
		
		//유효성 검사 결과 실패
		if(result.hasErrors()) {
			return "account/login";
		}
		
		//로그인 정보가 맞지 않음
		Member member;
		try {
			member = service.checkLogin(login);
			if(member==null) {
				return "account/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//로그인 성공
		return "redirect:/";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinForm(Member member) {
		return "account/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinSubmit(@Valid Member member, BindingResult result) {
		
		//유효성 검사 결과 실패
		if(result.hasErrors()) {
			return "account/join";
		}
		
		//아이디 중복
		try {
			if(service.checkId(member.getUserId())) {
				return "account/join";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//회원가입 성공
		try {
			if(service.create(member)) {
				return "redirect:/";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@ResponseBody	//리턴값은 뷰가 아님. 웹 브라우저로 응답하라
	@RequestMapping(value="/idcheck", method=RequestMethod.GET)
	public boolean checkId(@RequestParam("userId") String userId) {
		try {
			return service.checkId(userId);
		}catch(Exception e) {
			e.printStackTrace();
			return true;
		}
	}
}

package edu.iot.butter.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.iot.butter.exception.LoginFailException;
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
	public String loginSubmit(@Valid Login login, 
								BindingResult result, 
								HttpSession session) throws Exception{
		//유효성 검사 결과 실패
		if(result.hasErrors()) return "account/login";
	
		Member member = service.checkLogin(login); //여기서 예외 발생(로그인 실패)하면 handleLoginError()호출됨
		session.setAttribute("USER", member);
		return "redirect:/";
	}
	
	//로그인 예외 발생시 호출됨
	@ExceptionHandler(LoginFailException.class)
	public String handleLoginError(HttpServletRequest request, Exception e) {
		request.setAttribute("login", new Login()); //모델 객체도 전달
		request.setAttribute("error", e.getMessage());
		return "account/login";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinForm(Member member) {
		return "account/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinSubmit(@Valid Member member,
								BindingResult result,
								RedirectAttributes ra) throws Exception {
		//유효성 검사 결과 실패
		if(result.hasErrors()) return "account/join";
		
		ra.addFlashAttribute("member", member); //redirect된 페이지에서 한 번 쓰이고 세션에서 제거
		service.create(member); //여기서 예외 발생하면 handleError()호출됨
		return "redirect:account/join_success";
	}
	
	@RequestMapping(value="/join_success", method=RequestMethod.GET)
	public String joinSuccess() {
		return "account/join_success";
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
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();	//session 완전히 삭제
		return "redirect:/login";
	}
	/*	
	//데이터베이스 예외 발생시 호출됨
	@ExceptionHandler({SQLException.class, DataAccessException.class})
	public String handleError() {
		return "error/database_error"; //에러 화면 호출
	}
	*/
}

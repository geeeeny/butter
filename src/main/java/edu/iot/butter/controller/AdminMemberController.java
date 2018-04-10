package edu.iot.butter.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.iot.butter.model.Member;
import edu.iot.butter.model.Pagination;
import edu.iot.butter.model.Password;
import edu.iot.butter.service.MemberService;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	MemberService service;
	
	//회원 목록
	@RequestMapping("/list")
	public void list(@RequestParam(value="page", defaultValue="1") int page,
					 Model model) throws Exception{
		//목록 및 페이지 정보 추출
		Pagination pagination = service.getPagination(page);
		List<Member> list = service.getList(pagination);
		
		//view에 넘길 정보 구성
		model.addAttribute("pagination", pagination); 
		model.addAttribute("list", list);
		model.addAttribute("today", new Date());
		// /admin/member/list로 이동
	}
	
	//회원 추가
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public void createForm(Member member) {
		
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createSubmit(@Valid Member member, BindingResult result)throws Exception{
		if(result.hasErrors()||!service.create(member))
			return "admin/member/create";
		
		return "redirect:list";
	}
	
	//아이디 중복 체크
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
	
	//회원 정보 보기
	@RequestMapping(value="/view/{userId}", method=RequestMethod.GET)
	public String view(@PathVariable String userId, Model model) throws Exception{
		Member member = service.getMember(userId);
		model.addAttribute("member", member);
		return "admin/member/view";
	}
	
	//회원 정보 수정
	@RequestMapping(value="/edit/{userId}", method=RequestMethod.GET)
	public String editForm(@PathVariable String userId, Model model) throws Exception{
		Member member = service.getMember(userId);
		model.addAttribute("member", member);
		return "admin/member/edit";
	}
	
	@RequestMapping(value="/edit/{userId}", method=RequestMethod.POST)
	public String editSubmit(@Valid Member member, 
							BindingResult result, 
							@RequestParam(value="page", defaultValue="1") int page,	
							HttpSession session) throws Exception{
		if(result.hasErrors())return "admin/member/edit";
		
		//관리자 비밀번호 체크
		Member admin = (Member)session.getAttribute("USER");
		if(!admin.getPassword().equals(member.getPassword())) {
			result.reject("passwordNotMatch", "비밀번호가 맞지 않습니다.");
			return "admin/member/edit";
		}
		if(!service.updateByAdmin(member)) {
			result.reject("updateFail", "수정에 실패했습니다.");
			return "admin/member/edit";
		}
		return "redirect:/admin/member/view/"+member.getUserId()+"?page="+page;
	}
	
	//회원 비밀번호 수정
	@RequestMapping(value="/changepassword/{userId}", method=RequestMethod.GET)
	public String changePasswordForm(@PathVariable String userId, 
									Password password) throws Exception{
		password.setUserId(userId);
		return "admin/member/changepassword";
	}
	
	@RequestMapping(value="/changepassword/{userId}", method=RequestMethod.POST)
	public String changePasswordSubmit(@Valid Password password, 
									BindingResult result,
									@RequestParam(value="page", defaultValue="1") int page,
									HttpSession session) throws Exception {
		if(result.hasErrors())return "admin/member/changepassword";
		
		//관리자 비밀번호 체크
		Member admin = (Member)session.getAttribute("USER");
		if(!admin.getPassword().equals(password.getOldPassword())) {
			result.reject("passwordNotMatch", "관리자 비밀번호가 틀렸습니다.");
			return "admin/member/changepassword";
		}
		
		//정보 수정 처리
		if(!service.changePasswordByAdmin(password)) {	//실패한 경우
			result.reject("updateFail", "기존 비밀번호가 틀렸습니다.");
			return "admin/member/changepassword/"+password.getUserId();
		}

		return "redirect:/admin/member/view/"+password.getUserId()+"?page="+page;
	}
}

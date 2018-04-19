package edu.iot.butter.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import edu.iot.butter.model.Avata;
import edu.iot.butter.model.Member;
import edu.iot.butter.model.Password;
import edu.iot.butter.service.MemberService;

@Controller
@RequestMapping("/member")
public class ProfileController {
	@Autowired
	MemberService service; //AccountController의 service와 같은 객체(빈은 싱글톤이므로)
	
	public void setMember(HttpSession session, Model model) throws Exception {
		//세션의 내용을 모델 객체에 담아서 전달(수정일 등록일을 유지하기 위함)
		Member m = (Member)session.getAttribute("USER");
		Member member = service.getMember(m.getUserId());
		model.addAttribute("member", member);
		//return 생략시 url로 이동
	}
	
	@RequestMapping("/profile")
	public void profile(HttpSession session, Model model) throws Exception {
		setMember(session, model);
		//return 생략시 url로 이동
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public void editForm(HttpSession session, Model model) throws Exception {
		setMember(session, model);
		//return 생략시 url로 이동
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.POST)
	public String editSubmit(@Valid Member member, 
								BindingResult result, 
								@RequestParam("avata") MultipartFile mFile,
								HttpSession session) throws Exception {
		if(result.hasErrors())return "member/edit";
		
		//정보 수정 처리
		if(!service.update(member)) {	//실패한 경우
			result.reject("updateFail", "비밀번호가 일치하지 않습니다.");
			return "member/edit";
		}
		
		// 아바타 수정
		if(mFile != null && !mFile.isEmpty()) {
		service.updateAvata(new Avata(member.getUserId(),
		mFile.getBytes()));
		}
		
		session.setAttribute("USER", member);
		return "redirect:profile";
	}
	
	@RequestMapping(value="/changepassword", method=RequestMethod.GET)
	public void changePasswordForm(Password password) throws Exception {
		//return 생략시 url로 이동
	}
	
	@RequestMapping(value="/changepassword", method=RequestMethod.POST)
	public String editSubmit(@Valid Password password, 
								BindingResult result) throws Exception {
		if(result.hasErrors())return "member/changepassword";
		
		//정보 수정 처리
		if(!service.changePassword(password)) {	//실패한 경우
			result.reject("updateFail", "기존 비밀번호가 틀렸습니다.");
			return "member/changepassword";
		}

		return "redirect:profile";
		
	}
	
	//아바타 이미지 내보내기
	@RequestMapping(value="/avata", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getAvata( //ResponseEntity: HttpResponse를 추상화해주는 객체
			@RequestParam("userId") String userId) throws Exception {
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG); //mime type 지정
		// body, hearder, 응답코드
		return new ResponseEntity<byte[]>(service.getAvata(userId), headers, HttpStatus.OK);
	}
}

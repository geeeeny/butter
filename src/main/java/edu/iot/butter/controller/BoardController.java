package edu.iot.butter.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import edu.iot.butter.dao.AttachmentDao;
import edu.iot.butter.model.Attachment;
import edu.iot.butter.model.Board;
import edu.iot.butter.model.Image;
import edu.iot.butter.model.Pagination;
import edu.iot.butter.service.BoardService;
import edu.iot.butter.service.ImageService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService service;
	
	@Autowired
	AttachmentDao dao;
	
	@RequestMapping("/list")
	public void list(@RequestParam(value="page", defaultValue="1")int page,
					Model model) throws Exception{
		Pagination pagination = service.getPagination(page);
		List<Board> list = service.getList(pagination);
		model.addAttribute("pagination", pagination);
		model.addAttribute("list", list);
	}
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public void createForm(Board board) {
		
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createSubmit(@Valid Board board, BindingResult result,
								MultipartHttpServletRequest request) throws Exception {
		if(result.hasErrors()) {
			System.out.println(result);
			return "board/create";
		}
		
		List<MultipartFile> attachments = request.getFiles("files");
		if(!service.create(board, attachments)) {
			result.reject("updateFail", "비밀번호가 일치하지 않습니다.");
			return "board/create";
		}
		
		return "redirect:list";
	}
	
	@RequestMapping(value="/view/{boardId}", method=RequestMethod.GET)
	public String view(@PathVariable int boardId, Model model) throws Exception{
		Board board = service.getBoard(boardId);
		model.addAttribute("board", board);
		return "board/view";
	}
	
	@RequestMapping(value="/download/{attachmentId}", method=RequestMethod.GET)
	public String download(@PathVariable int attachmentId, Model model) throws Exception{
		Attachment file = service.getAttachment(attachmentId);
		
		String path = "c:/temp/upload"+"/"+file.getLocation();
		model.addAttribute("type", "application/octet-stream");
		model.addAttribute("path", path);
		model.addAttribute("fileName", file.getFileName());
		
		//file.readyDownload("c:/temp/upload/", model);
		
		return "download"; 	//사용자 정의 뷰 이름. beanNameResolver로 호출됨
	}
	
	@RequestMapping(value="/edit/{boardId}", method=RequestMethod.GET)
	public String editForm(@PathVariable int boardId, Model model) throws Exception{
		Board board = service.getBoard(boardId);
		model.addAttribute("board", board);
		return "board/edit";
	}
	
	@RequestMapping(value="/edit/{boardId}", method=RequestMethod.POST)
	public String editSubmit(@Valid Board board, BindingResult result,
							MultipartHttpServletRequest request) throws Exception{
		if(result.hasErrors()) return "board/edit";
		
		List<MultipartFile> attachments = request.getFiles("files");
		
		if(!service.update(board, attachments)) {
			System.out.println(board);
			result.reject("updateFail", "비밀번호가 일치하지 않습니다.");
			return "board/edit";
		}
		return "redirect:/board/list";
	}
}

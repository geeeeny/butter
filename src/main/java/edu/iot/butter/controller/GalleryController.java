package edu.iot.butter.controller;

import java.util.Date;
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

import edu.iot.butter.model.Image;
import edu.iot.butter.model.Pagination;
import edu.iot.butter.service.ImageService;

@Controller
@RequestMapping("/gallery")
public class GalleryController {
	
	@Autowired
	ImageService service;
	
	@RequestMapping("/flickr")
	public void flick() {
		
	}
	
	@RequestMapping("/lightbox")
	public void lightbox(@RequestParam(value="page", defaultValue="1") int page,
						Model model) throws Exception{
		Pagination pagination = service.getPagination(page);
		model.addAttribute("pagination", pagination);
		model.addAttribute("list", service.getList(pagination));
		model.addAttribute("today", new Date());
	}
	
	@RequestMapping("/thumb/{imageId}")
	public String thumb(@PathVariable int imageId, Model model) throws Exception{
		Image image = service.getImage(imageId);
		String path = ImageService.THUMB_DIR+"/"+image.getThumbName();
		
		model.addAttribute("type", image.getMimeType());
		model.addAttribute("path", path);
		
		return "fileView"; 	//사용자 정의 뷰 이름
	}
	
	@RequestMapping("/image/{imageId}")
	public String image(@PathVariable int imageId, Model model) throws Exception{
		Image image = service.getImage(imageId);
		String path = ImageService.IMAGE_DIR+"/"+image.getNewName();
		
		model.addAttribute("type", image.getMimeType());
		model.addAttribute("path", path);
		
		return "fileView"; 	//사용자 정의 뷰 이름. beanNameResolver로 호출됨
	}
	
	@RequestMapping("/download/{imageId}")
	public String download(@PathVariable int imageId, Model model) throws Exception{
		Image image = service.getImage(imageId);
		String path = ImageService.IMAGE_DIR+"/"+image.getNewName();
		
		model.addAttribute("type", image.getMimeType());
		model.addAttribute("path", path);
		model.addAttribute("fileName", image.getFileName());
		
		return "download"; 	//사용자 정의 뷰 이름. beanNameResolver로 호출됨
	}
	
	@RequestMapping("/carousel")
	public void carousel(@RequestParam(value="page", defaultValue="1")int page,
						Model model) throws Exception{
		Pagination pagination = service.getPagination(page);
		model.addAttribute("pagination", pagination);
		model.addAttribute("list", service.getList(pagination));
	}
	
	@RequestMapping(value="/upload",method=RequestMethod.GET)
	public void uploadForm(Image image)throws Exception{
		
	}
	
	@RequestMapping(value="/upload",method=RequestMethod.POST)
	public String uploadSubmit(@Valid Image image, 
							BindingResult result,
							MultipartHttpServletRequest request)throws Exception{
		if(result.hasErrors()) return "gallery/upload";
		List<MultipartFile> fileList = request.getFiles("imageFiles");
		System.out.println(image.getTitle());
		System.out.println(fileList);
		service.upload(image, fileList);
		
		return "redirect:lightbox";
	}
}

package edu.iot.butter.view;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import edu.iot.butter.util.FileUtil;

@Component("fileView")	//뷰 이름 설정(빈 이름 생략시 클래스명(->첫 글자 소문자)으로 등록됨)
public class FileView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String path = (String)model.get("path");
		String type = (String)model.get("type");
		
		File file = new File(path);
		
		//응답 헤더 설정
		response.setContentType(type);
		response.setContentLength((int)file.length());
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		FileUtil.copy(path, response);
	}

}

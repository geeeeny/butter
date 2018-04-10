package edu.iot.butter.service;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import edu.iot.butter.dao.ImageDao;
import edu.iot.butter.model.Image;
import edu.iot.butter.model.Pagination;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

@Service
public class ImageServiceImpl implements ImageService {

	@Autowired
	ImageDao dao;

	@Override
	public Pagination getPagination(int page) throws Exception {
		int total = 123;// int total = dao.getCount();
		Pagination pagination = new Pagination(page, total);
		return pagination;
	}

	@Override
	public List<Image> getList(Pagination pagination) throws Exception {
		return dao.selectList(pagination);
	}

	@Override
	public Image getImage(int id) throws Exception {
		return dao.selectOne(id);
	}

	@Transactional
	@Override
	public boolean upload(Image image, List<MultipartFile> fileList) throws Exception {
		for (MultipartFile file : fileList) {
			if (!file.isEmpty()) {

				saveImage(image, file);

				// DB에 저장
				dao.insert(image);
			}
		}
		return true;
	}

	@Autowired
	ServletContext context;

	// 업로드 파일 저장, thumbnail 생성, Image 정보 설정
	public void saveImage(Image image, MultipartFile file) throws Exception {
		String fileName = file.getOriginalFilename();
		String newName = saveImage(fileName, file);
		String thumbName = saveThumb(newName);
		Tika tika = new Tika();
		String mimeType = tika.detect(fileName);
		image.setFileName(fileName);
		image.setMimeType(mimeType);
		image.setFileSize(file.getSize());
		image.setNewName(newName);
		image.setThumbName(thumbName);
	}

	// 이름 충돌없게 timestamp 추가하여 새로운 파일명 배정 후 저장
	// 새로운 파일명 리턴
	public String saveImage(String fname, MultipartFile file) throws Exception {
		long fileNo = System.currentTimeMillis();
		String newName = fileNo + "_" + fname;	//파일명에 현재 날짜를 붙여 저장 
		String path = IMAGE_DIR + "/" + newName;
		// 업로드 된 파일명 재지정
		file.transferTo(new File(path));
		return newName;
	}

	// Thumbnail 파일 생성 및 Thumbnail 파일명 리턴
	public String saveThumb(String fname) throws Exception {
		String thumbName = "thumbnail-" + fname;
		// Thumbnail 파일 생성
		Thumbnails
				.of(new File(IMAGE_DIR + "/" + fname))
				.crop(Positions.CENTER) // 사이즈 넘으면 자른다.
				.size(200, 200)
				.toFile(new File(THUMB_DIR + "/" + thumbName));
		return thumbName;
	}
}

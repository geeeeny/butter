package edu.iot.butter.model;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Attachment {
	public Attachment(int boardId, String fname, String newName) {
		this.boardId = boardId;
		this.fileName = fname;
		this.location = newName;
	}
	private int attachmentId;
	private int boardId;		//게시글 ID
	private String fileName;	//원본 파일명
	private String location;	//서버에서의 파일명
	private Date regDate;
	
	
}
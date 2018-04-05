package edu.iot.butter.model;

import java.util.Date;

import lombok.Data;

@Data
public class Image {
	private int imageId;
	private String title;
	private String description;
	private String fileName;
	private String thumbName;
	private int fileSize;
	private String mimeType;
	private Date regDate;
}

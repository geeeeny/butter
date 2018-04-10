package edu.iot.butter.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileUtil {
	// 지정한 파일을 브라우저로 전송
	public static void copy(String path, HttpServletResponse response) {
		try (InputStream in = new BufferedInputStream(new FileInputStream(path));
				OutputStream out = new BufferedOutputStream(response.getOutputStream());) {

			int data;
			while ((data = in.read()) != -1) {
				out.write(data);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

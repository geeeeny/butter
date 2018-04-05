package edu.iot.butter;

import com.google.gson.Gson;

import edu.iot.butter.model.Member;

public class GsonTest {
	public static void main(String[] args) {
		Member member = new Member();
		member.setUserId("hong");
		member.setName("홍길동");
		member.setPassword("1234");
		
		Gson gson = new Gson();
		String json = gson.toJson(member);
		System.out.println(json);//{"userId":"hong","name":"홍길동","password":"1234","grade":0}
		
		Member member2 = gson.fromJson(json, Member.class);
		System.out.println(member2);//Member(userId=hong, name=홍길동, password=1234, cellPhone=null, email=null, address=null, grade=0, regDate=null, updateDate=null)
	}
}

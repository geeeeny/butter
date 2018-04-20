package edu.iot.butter.handler;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import edu.iot.butter.model.Member;
import edu.iot.butter.model.Talk;
import edu.iot.butter.service.TalkService;

@Component
public class TalkHandler extends TextWebSocketHandler {

	// 동기화 맵 생성
	Map<WebSocketSession, String> sessionMap = Collections.synchronizedMap(new HashMap<>());
	Map<String, WebSocketSession> memberMap = Collections.synchronizedMap(new HashMap<>());

	@Autowired
	TalkService service;

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String memberId = sessionMap.remove(session);
		memberMap.remove(memberId);

		super.afterConnectionClosed(session, status);
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Member member = (Member) session.getAttributes().get("USER");
		sessionMap.put(session, member.getUserId());
		memberMap.put(member.getUserId(), session);
		super.afterConnectionEstablished(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메시지 수신자 식별 및 처리
		Gson gson = new Gson(); 
		Talk talk = gson.fromJson(message.getPayload(), Talk.class); 
		
		// 전송자의 전송 talk 저장 
		service.create(talk); 
		
		send(talk, message); 
		super.handleTextMessage(session, message);
	}

	public void send(Talk talk, TextMessage message) throws Exception{
		WebSocketSession s = memberMap.get(talk.getWithTalk());
		if(s!=null) { //수신자 접속시 checked 1
			s.sendMessage(message);
			saveTalk(talk, 1);
		}else { 	  //수신자 미접속시 checked 0
			saveTalk(talk, 0);
		}
	}
	
	public void saveTalk(Talk talk, int checked) throws Exception{
		//수신자측 수신 Talk 저장
		Talk talk2 = Talk.builder()
				.userId(talk.getWithTalk())
				.withTalk(talk.getUserId())
				.checked(checked)
				.received(1)
				.message(talk.getMessage())
				.build();
		service.create(talk2);
	}
}

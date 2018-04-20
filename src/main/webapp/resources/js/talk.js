var talkTempl = {
	sendTempl: function(msg){
		return `
		<div class="media my-1">
			<img src="/butter/member/avata?userId=${msg.userId}"
				class="d-flex mr-3 rounded-circle avata">
			<div class="media-body text-left ml-3 mr-5">
				<div class="small">${msg.regDate.str()}</div>
				<div class="talk-message send-message">
					${msg.message}</div>
			</div>
		</div>`;
	},
	
	receiveTempl: function(msg){
		return `
		<div class="media my-1">
			<div class="media-body text-left ml-3 mr-5">
				<div class="small">${msg.regDate.str()}</div>
				<div class="talk-message send-message">
					${msg.message}</div>
			</div>
			<img src="/butter/member/avata?userId=${msg.withTalk}"
				class="d-flex mr-3 rounded-circle avata">
		</div>`;
	}
	
}

class Talk{
	constructor(opt){
		this.opt = opt;
		
		//웹 소켓 접속
		this.socket = new SockJS(this.opt.url+'/talk');
		
		//이벤트 핸들러를 Talk 객체의 프로토타입 메서드로 설정
		//호출된 이벤트 핸들러 내에 this를 현재 인스턴스로 바인딩
		this.socket.onopen = this.onopen.bind(this); 
		this.socket.onmessage = this.onmessage.bind(this); 
		this.socket.onclose = this.onclose.bind(this); 
		this.socket.onerror = this.onerror.bind(this);
		

		//이전 talk 리스트 받아 초기화
		$.get(opt.url + '/talkList', { 
			userId : this.opt.userId, 
			withTalk : this.opt.withTalk 
		}, this.initMessage.bind(this));
	}

	initMessage(messages) { 
		var self = this; 
		messages.forEach( function(msg) { 
			msg.regDate = new Date(msg.regDate);
			if(msg.received == 1) { // 수신 데이터 
				self.opt.panel.append(talkTempl.receiveTempl(msg)); 
			} else { // 전송 데이터 
				self.opt.panel.append(talkTempl.sendTempl(msg)); 
				} 
		}); 
		self.opt.panel.parent().scrollTop(self.opt.panel.height()); 
	}
	
	// 접속 성공 이벤트 핸들러 
	onopen(){ 
		console.log('접속 성공'); 
	} 
	
	// 접속 해제 이벤트 핸들러 
	onclose(){ 
		console.log('접속 해제'); 
	} 
	
	// 에러 이벤트 핸들러 
	onerror(e) { 
		console.log('에러', e); 
	}
	
	// 메시지 수신 이벤트 핸들러
	onmessage(msg) { 
		this.opt.panel.append(talkTempl.receiveTempl(msg)); 
		this.opt.panel.parent().scrollTop(this.opt.panel.height()); 
	} 
	
	// 전송 메시지 템플릿 추가 
	addSendTempl(msg) { 
		this.opt.panel.append(talkTempl.sendTempl(msg)); 
		this.opt.panel.parent().scrollTop(this.opt.panel.height()); 
	}
	
	// 메시지 전송
	send(message) {
		var msg = { 
			userId : this.opt.userId,
			withTalk : this.opt.withTalk, 
			received : 0, 
			message : message, 
			checked : 1 
		}; 
		// console.log(JSON.stringify(msg)); 
		this.socket.send(JSON.stringify(msg)); 
		msg.regDate = new Date();
		return msg; 
	}
}

$.fn.talk = function(opt) { 
	opt = $.extend(opt, {panel: this}); // 메시지 출력 엘리먼트 설정 
	var talk = new Talk(opt); // 전송 버튼 이벤트 핸들러 
	opt.sendBtn.click(function () { 
		var message = opt.sendMessage.val(); 
		if(message.trim() == '') return; // 메시지 없는 경우 취소 
		
		var msg = talk.send(message); // 메시지 전송 
		talk.addSendTempl(msg); // 전송 Talk 화면 출력 
		opt.sendMessage.val('').focus(); // 전송 메시지 입력 창 지움 
	}); 
}
	

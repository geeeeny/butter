var templ = {
	tableTempl: `
		<table class="table">
			<tbody>
			</tbody>
		</table>
	`,
		
	trTempl: function(image){
		return `
		<tr>
			<td style="width:100px">
				<a href="image/${image.imageId}" data-lightbox="roadtrip">
					<img src="thumb/${image.imageId}" 
							width="100"
							alt="${image.title}"
							class="z-depth-2 rounded"/>
				</a>
			</td>
			<td>
				<p>
					<b>${image.title}</b>
					<a href="download/${image.imageId}"> 
						<i class="fa fa-download"></i>
					</a>
					 ${image.title}
				</p>
			</td>
		</tr>`;
	}
}

class Image{
	constructor(opt){
		this.opt = opt;	//this는 talk 인스턴스
		
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
		messages.forEach(function(msg) { 
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
	onmessage(item) { 
		this.opt.panel.append(imageTempl.imageTempl(item)); 
	} 
	
	// 전송 메시지 템플릿 추가 
	addImageTempl(item) { 
		this.opt.panel.append(imageTempl.imageTempl(item)); 
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
$.fn.gallery = function(opt) { 
	var self = this;
	var api = new Rest(opt.url);
	
	api.list('', function(images){
		images.forEach(function(image){
			var tr = templ.trTempl(image);
			self.find('tbody').append(tr);
		});
	});
	
	return self;
}
	
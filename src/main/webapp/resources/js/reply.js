$.fn.replyBoard = function(opt, replyList) { //jQeury 클래스의 프로토타입에 지정
	var templ = $(replyTempl.replyAddTempl);
	var content = templ.find('#reply-content');
	templ.find('#reply-add').click(function(e){
		var reply = {
			boardId : opt.boardId,
			writer : opt.writer,
			parent : 0,
			replyLevel : 0,
			content : content.val()
		};
		opt.api.create(reply, function(data) {
			data.regDate = new Date(data.regDate); // 문자열 -> Date 변환
			content.val(''); // <textarea> 내용 지우기
			// 댓글 리스트에 추가 
			opt.replyList.prepend( replyTempl.mediaObejctTempl(data, opt.writer));
		});
	});
	this.append(templ);
	return this;
}

//1차원 배열(레벨 오름차순, 최근 등록순)을 트리 구조로 변경 
function makeDom(datas) { 
	var dom = []; // 새로 정렬될 데이터 배열 
	var objects = {}; // replyId를 키로, reply를 값으로 하는 맵 
	datas.forEach(data=>{ 
		data.regDate = new Date(data.regDate); 
		data.children = []; // 하위 댓글을 위한 배열 
		objects[data.replyId] = data; // 맵 등록 
		if(data.parent == 0) { // 최상위 댓글 
			dom.push(data); // dom 배열에 추가 
		} else { 
			// 하위 댓글인 경우 부모의 children 배열에 추가
			objects[data.parent].children.push(data);  //부모는 자식보다 먼저 처리됨
		} 
	}) 
	return dom; 
}

//트리 구조를 탐색하여 Media Object 구조 생성 - 재귀호출
function makeMediaObject(writer, item) {
	// 단말(leaf) reply (자식이 없는 reply)
	if(item.children.length==0) {
		return replyTempl.mediaObjectTempl(item, writer);
	}
	// 중간 reply
	var self = replyTempl.mediaObjectTempl(item, writer);
	// 자식 reply에 대해서 재귀 호출
	item.children.forEach(child=>{
		var child = makeMediaObject(writer, child);
		self.find('.children').append(child);
	});
	return self;
}

$.fn.replyList = function(opt) { 
	var self = this; 
	
	// 초기 목록 구성 
	opt.api.list('', function(datas) { 
		// 레벨순, 등록역순 배열을 트리구조 배열로 변환 
		makeDom(datas).forEach( 
			item=>self.append( 
				makeMediaObject(opt.writer, item) 
			) 
		); 
	}); 
	return this; 
}

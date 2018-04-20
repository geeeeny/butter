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
			opt.replyList.prepend( replyTempl.mediaObjectTempl(data, opt.writer));
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
		self.find('.children').eq(0).append(child);
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
	
	// 댓글 쓰기 판넬 보여주기, this는 reply 버튼
	function showReplyPanel() {
		var parent = $(this).closest('.media-body'); //가장 가까이에 있는 media-body를 찾음
		parent.children('.work').append(replyTempl.addTempl); // 하위 댓글 작성 추가
	}
	// 댓글 쓰기 판넬 제거하기, this는 취소 버튼
	function hideReplyPanel() {
		$(this).parent().empty();
	}
	
	// 댓글 등록, this는 하위댓글 등록 버튼
	function createReply() {
		var obj = $(this).closest('.media');
		var reply = {
			boardId : opt.boardId,
			writer : opt.writer,
			parent : parseInt(obj.data('reply-id')),
			replyLevel : parseInt(obj.data('reply-level'))+1,
			content : obj.find('textarea').val()
		}
		opt.api.create(reply,function(result){
			if(result) {
				result.regDate = new Date(result.regDate);
				obj.find('.children').eq(0).prepend(replyTempl.mediaObjectTempl(result,reply.writer));
				obj.find('.work').empty();
			} else {
				alert('댓글 쓰기 실패')
			}
		});
	}
	
	// 댓글 수정 창 보이기, this는 수정 버튼
	function showEditPanel() {
		var content = $(this).closest('.media-body ').children('.reply-content');
		var text = content.text(); // 현재 내용 추출
		content.empty() // 현재 내용 화면 제거
			.data('old', text) // 취소시 복원용 이전 데이터
			.append(replyTempl.editTempl); // 수정창 추가
		content.find('textarea').val(text); // 수정창에 데이터 설정
	}
	
	// 댓글 수정 창 제거, this는 취소 버튼
	function hideEditPanel() {
		var text = $(this).parent().data('old'); // 이전 데이터 추출
		$(this).parent()
			.empty() // 현재 내용 제거
			.text(text); // 이전 데이터로 복원
	}
	
	// 댓글 수정 등록, this는 등록 버튼
	function editReply() {
		var obj = $(this).parent();
		var reply = {
			replyId : $(this).closest('.media').data('reply-id'),
			content : obj.find('textarea').val()
		};
		api.update(reply, function(result){
			if(result) {
				result.regDate = new Date(result.regDate);
				obj.empty().text(reply.content);
			} else {
				alert('수정 실패');
			}
		});
	}
	
	//댓글 삭제 이벤트 핸들러, this는 삭제 버튼 
	function deleteContent() { 
		var self = $(this); 
		var media = $(this).closest('.media'); 
		opt.api.remove(media.data('reply-id'), // replyId 추출 
				function(result){ 
			if(result) { // 삭제 성공시 
					media.find('.reply-content').eq(0) .text('삭제된 글입니다.'); 
					self.parent().remove(); // 버튼 그룹 제거 
			} else { 
				alert('삭제 실패'); 
			} 
		}); 
		
	}

	
	// 하위 댓글 추가 관련
	this.on('click', '.reply-add-show', showReplyPanel);
	this.on('click', '.reply-cancel', hideReplyPanel);
	this.on('click', '.reply-add',createReply);
	// 댓글 수정 관련 이벤트 핸들러 등록 
	this.on('click', '.reply-edit-show', showEditPanel); 
	this.on('click', '.reply-edit-cancel',hideEditPanel); 
	this.on('click', '.reply-edit', editReply);
	// 댓글 삭제 관련 이벤트 핸들러
	this.on('click', '.reply-delete',deleteContent);
	
	return this; 
}

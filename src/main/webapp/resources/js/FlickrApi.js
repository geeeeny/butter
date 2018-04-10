class FlickrApi{
	constructor(){
		// jsonp 호출을 위한 url
		this.url =
			'https://api.flickr.com/services/rest/?jsoncallback=?';
		this.api_key = '31cf0e33da391002bdf1d9725c332398';
		this.format = 'json'; // json 타입으로 리턴한다.
	}
	
	/* 최근 등록된 이미지를 얻어오는 메서드 */
	getRecent(parse){	// 프로토타입 메서드
		parse = parse||this.parse;
		var param = {
			api_key: this.api_key,
			method: 'flickr.photos.getRecent',	
			per_page: 20,	// 한 페이지당 20개 이미지
			format: this.format
		};
		
		$.getJSON(this.url, param, parse);
	}
	
	/* 저장되어 있는 이미지를 검색하기 위한 메서드 */
	search(keyword, parse) {
		parse = parse||this.parse;
		var param = {
		api_key : this.api_key,
		method : 'flickr.photos.search',
		// text : keyword,
		tags : keyword,
		content_type : 1,
		safe_search : 1,
		sort : 'interestingness-desc',
		per_page : 10,
		format : this.format
		};
		$.getJSON(this.url, param, parse);
		}
	
	parse(data){
		$('#panel').empty(); //기존의 내용을 지움
		
		$(data.photos.photo).each(function(i, photo){
			// 작은 이미지
			var img =`http://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}.jpg`; 
			console.log(img);
			
			// 이미지 정보 페이지
			var img_info =`http://www.flickr.com/photos/${photo.owner}/${photo.id}/in/photostream`;
			console.log(img_info);
			
			var templ = `
				<div class="col-md-4 mb-4">
					<div class="view zoom">
						<a href="${img_info}" target="_blank">
							<img src="${img}" width="200" class="z-depth-2 img-fluid">
						</a>
						<div class="mask flex-center"></div>
					</div>
				</div>
			`;

			$(templ).appendTo('#panel');
		});
		
	}
}

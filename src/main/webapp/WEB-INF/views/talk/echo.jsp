<%@ page contentType="text/html; charset=utf-8" %>
<script
src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.js">
</script>

<script>
$(function(){
	var socket = new SockJS("echo"); // "/butter/talk/echo"
	socket.onopen = function(){
		console.log('접속 성공');
		//접속후 바로 데이터 전송
		socket.send('Hello');
	}
	
	socket.onclose = function(){
		console.log('접속 해제');
	}
	
	socket.onmessage = function(msg){
		console.log('데이터 수신: ', msg.data);
	}
	
	socket.onerror = function(err){
		console.log('에러 ', err);
	}
});
</script>

<h1>웹 소켓 테스트</h1>
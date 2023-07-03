function getId(id){
	return document.getElementById(id);
}

//	전송 데이터(JSON)
let data = {};

let ws ;
let memberId = getId('member-id');
let memberNickname = getId('member-nickname');
let sendBtn = getId('send-btn');
let talk = getId('talk');
let msg = getId('msg');

window.onload = function() {
	
	ws = new WebSocket("ws://" + location.host + "/chat");
	
	ws.onmessage = function(msg) {
		
		let data = JSON.parse(msg.data);
		let css;
		
		if (data.memberId == memberId.value) {
			css = 'class=me';
		} else {
			css = 'class=other';
		}
		
		let item = `<div ${css}>
		            	<span><b>${data.memberNickname}</b></span> [${data.date}]<br/>
                    	<span>${data.msg}</span>
					</div>`;
					
		talk.innerHTML += item;
		//	스크롤바 하단으로 이동
		talk.scrollTop = talk.scrollHeight;
		
	}
	
}

msg.onkeyup = function(event) {
	
	if(event.keyCode == 13){
		send();
	}
	
}

sendBtn.onclick = function() {
	send();
}

function send() {
	
	if (msg.value.trim() != '') {
		data.memberId = getId('member-id').value;
		data.memberNickname = getId('member-nickname').value;
		data.msg = msg.value;
		data.date = new Date().toLocaleString();
		let temp = JSON.stringify(data);
		ws.send(temp);
	}
	
	msg.value ='';
	
}
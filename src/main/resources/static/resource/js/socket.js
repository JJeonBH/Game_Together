'use strict';

let stompClient = null;
let memberId = null;
let memberNickname = null;
let connectingElement = document.querySelector('#connecting');
let messageArea = document.querySelector('#messageArea');
let messageForm = document.querySelector('#messageForm');
let messageInput = document.querySelector('#messageInput');

//	chatRoomId 파라미터 가져오기
const url = new URL(location.href).searchParams;
const chatRoomId = url.get('chatRoomId');

window.onload = function connect(event) {
	
	memberId = document.querySelector('#member-id').value.trim();
	memberNickname = document.querySelector('#member-nickname').value.trim();
	
	//	연결하고자하는 Socket 의 endPoint
	let socket = new SockJS('/ws-stomp');
    stompClient = Stomp.over(socket);
	
	stompClient.connect({}, onConnected, onError);
	
	event.preventDefault();

}

function onConnected() {

    //	sub 할 url => /sub/usr/chat/joinChatRoom/chatRoomId 로 구독한다
    stompClient.subscribe('/sub/usr/chat/joinChatRoom/' + chatRoomId, onMessageReceived);
    
    //	서버에 memberNickname 을 가진 멤버가 들어왔다는 것을 알림
    //	/pub/usr/chat/enterMember 로 메시지를 보냄
    stompClient.send("/pub/usr/chat/enterMember",
        {},
        JSON.stringify({
            "chatRoomId" : chatRoomId,
            "memberId" : memberId,
            "message" : memberNickname + '님이 입장하셨습니다.',
            "memberNickname" : memberNickname,
            "messageType" : 'ENTER'
        })
    )
    
	connectingElement.classList.add('hidden');

}

function onError(error) {
	
	alert(error);
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
    
}

//	유저 리스트 받기
//	ajax 로 유저 리스트를 받으며 클라이언트가 입장/퇴장 했다는 문구가 나왔을 때마다 실행된다.
//function getUserList() {
//    const $list = $("#list");
//    
//    $.ajax({
//        type: "GET",
//        url: "/chat/userlist",
//        data: {
//            "roomId": roomId
//        },
//        success: function (data) {
//            var users = "";
//            for (let i = 0; i < data.length; i++) {
//                //console.log("data[i] : "+data[i]);
//                users += "<li class='dropdown-item'>" + data[i] + "</li>"
//            }
//            $list.html(users);
//        }
//    })
//}

//	메시지 전송때는 JSON 형식의 메시지를 전달한다.
function sendMessage(event) {
	
    let messageContent = messageInput.value.trim();

    if (messageContent && stompClient) {
		
        let chatMessage = {
            "chatRoomId" : chatRoomId,
            "memberId" : memberId,
            "message" : messageContent,
            "memberNickname" : memberNickname,
            "messageType" : 'TALK'
        };

        stompClient.send("/pub/usr/chat/sendMessage", {}, JSON.stringify(chatMessage));
        
        messageInput.value = '';
        
    }
    
    event.preventDefault();
    
}

//	메시지를 받을 때도 마찬가지로 JSON 타입으로 받으며,
//	넘어온 JSON 형식의 메시지를 parse 해서 사용한다.
function onMessageReceived(payload) {
	
    let chat = JSON.parse(payload.body);
    
    let messageElement = document.createElement('li');

    if (chat.messageType == 'ENTER') {
        messageElement.classList.add('event-message');
    } else if (chat.messageType == 'LEAVE') {
        messageElement.classList.add('event-message');
    } else {
		
		if (memberId == chat.memberId) {
			messageElement.classList.add('me');
		} else {
			messageElement.classList.add('other');
		}
		
		let memberNicknameElement = document.createElement('span');
		let memberNicknameText = document.createTextNode(chat.memberNickname);
		
		memberNicknameElement.appendChild(memberNicknameText);
		messageElement.appendChild(memberNicknameElement);
		
    }
    
    let contentElement = document.createElement('p');
    let messageText = document.createTextNode(chat.message);
    
    contentElement.appendChild(messageText);
    
	messageElement.appendChild(contentElement);
	
    messageArea.appendChild(messageElement);
    
    //	스크롤바 하단으로 이동
    messageArea.scrollTop = messageArea.scrollHeight;
    
}

messageForm.addEventListener('submit', sendMessage, true)
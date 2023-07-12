'use strict';

let stompClient = null;
let memberId = null;
let memberNickname = null;
let connectingElement = document.querySelector('#connecting');

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
            "memberNickname" : memberNickname,
            "messageType" : 'ENTER'
        })
    )
    
	connectingElement.classList.add('hidden');

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

function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}

//	메시지 전송때는 JSON 형식을 메시지를 전달한다.
function sendMessage(event) {
    var messageContent = messageInput.value.trim();

    if (messageContent && stompClient) {
        var chatMessage = {
            "roomId": roomId,
            sender: username,
            message: messageInput.value,
            type: 'TALK'
        };

        stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}

//	메시지를 받을 때도 마찬가지로 JSON 타입으로 받으며,
//	넘어온 JSON 형식의 메시지를 parse 해서 사용한다.
function onMessageReceived(payload) {
    //console.log("payload 들어오냐? :"+payload);
    let chat = JSON.parse(payload.body);

    let messageElement = document.createElement('li');

    if (chat.messageType === 'ENTER') {
        messageElement.classList.add('event-message');
        chat.content = chat.sender + chat.message;
        getUserList();
    } else if (chat.type === 'LEAVE') { // chatType 가 leave 라면 아래 내용
        messageElement.classList.add('event-message');
        chat.content = chat.sender + chat.message;
        getUserList();

    } else { // chatType 이 talk 라면 아래 내용용
        messageElement.classList.add('chat-message');

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(chat.sender[0]);
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(chat.sender);

        messageElement.appendChild(avatarElement);

        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(chat.sender);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
    }

    var textElement = document.createElement('p');
    var messageText = document.createTextNode(chat.message);
    textElement.appendChild(messageText);

    messageElement.appendChild(textElement);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}

function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }

    var index = Math.abs(hash % colors.length);
    return colors[index];
}

//messageForm.addEventListener('submit', sendMessage, true)
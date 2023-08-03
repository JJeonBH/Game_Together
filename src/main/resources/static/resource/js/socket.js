'use strict';

let stompClient = null;
let memberId = null;
let memberNickname = null;
let hostMemberId = null;
let connectingElement = document.querySelector('#connecting');
let messageArea = document.querySelector('#message-area');
let messageForm = document.querySelector('#message-form');
let messageInput = document.querySelector('#message-input');
let exitButton = document.querySelector('#exit-button');

//	URL 에서 chatRoomId 파라미터 값 가져오기
const url = new URL(location.href).searchParams;
const chatRoomId = url.get('chatRoomId');

window.onload = function connect(event) {
	
	//	주소창 누르고 새로고침하면 퇴장, 입장 반복되던 부분 안되게
	if (performance.navigation.type == 1) {
		alert("정상적인 접근이 아닙니다.");
		location.href = '/usr/chat/chatRoomList';
		return;
	}
	
	memberId = document.querySelector('#member-id').value.trim();
	memberNickname = document.querySelector('#member-nickname').value.trim();
	hostMemberId = document.querySelector('#host-member-id').value.trim();
	
	//	연결하고자 하는 Socket 의 endPoint (WebSocketStompConfig에서 정한 endPoint)
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
    stompClient.send('/pub/usr/chat/enterMember',
        {},
        JSON.stringify({
            'chatRoomId' : chatRoomId,
            'memberId' : memberId,
            'message' : memberNickname + ' 님이 입장하셨습니다.',
            'memberNickname' : memberNickname,
            'messageType' : 'ENTER'
        })
    )
    
	connectingElement.classList.add('hidden');

}

function onError(error) {
	
	alert(error);
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
    
}

async function disconnect(event) {
	
	await stompClient.send('/pub/usr/chat/exitMember',
	    {},
	    JSON.stringify({
	        'chatRoomId' : chatRoomId,
	        'memberId' : memberId,
	        'message' : memberNickname + ' 님이 퇴장하셨습니다.',
	        'memberNickname' : memberNickname,
	        'messageType' : 'LEAVE'
	    })
	)
    
    await stompClient.disconnect();
    
    event.preventDefault();
    
	location.href = '/usr/chat/chatRoomList';
	
}

//	채팅방에 입장한 멤버 리스트 받기
//	비동기로 멤버 리스트를 받으며 클라이언트가 입장/퇴장 했다는 문구가 나올 때마다 실행된다.
function getMemberList() {
	
    let memberList = $('#member-list');
    
    $.ajax({
        type: 'GET',
        url: '/usr/chat/memberList',
        data: {
            'chatRoomId': chatRoomId
        },
        success: function (data) {
			let members = '';
			for (let i = 0; i < data.length; i++) {
				if (data[i].id == memberId) {
					members += `<li class="p-1">
									<span>
										<span class="cursor-pointer ${data[i].id == memberId ? 'text-green-500' : ''}">${data[i].nickname}</span>
									</span>
								</li>`;
				} else {
					members += `<li class="p-1">
									<span>
										<span class="cursor-pointer ${data[i].id == memberId ? 'text-green-500' : ''}" onclick="showCommandList('${data[i].sessionId}');">${data[i].nickname}</span>
										<ul id="${data[i].sessionId}" class="hidden">`;
					if (memberId == hostMemberId) {
						members += `			<li>
													<span class="cursor-pointer" onclick="banMember('${data[i].sessionId}');">강퇴</span>
												</li>
												<li>
													<span class="cursor-pointer">귓속말 보내기</span>
												</li>
											</ul>
										</span>
									</li>`;
					} else {
						members += `			<li>
													<span class="cursor-pointer">귓속말 보내기</span>
												</li>
											</ul>
										</span>
									</li>`;
					}
				}
			}
			memberList.empty();
			memberList.html(members);
        }
    })
    
}

//	멤버 리스트에 있는 멤버를 클릭할 때 강퇴, 귓속말 보내기 등의 명령어 목록 보여주기(자기 자신은 제외)
//	클릭한 상태에서 동일한 멤버를 한번 더 클릭하면 명령어 목록 사라지게 함
//	클릭한 상태에서 다른 멤버를 클릭하면 기존 명령어 목록 사라지고 다른 명령어 목록 보여주게 함
let originalCommandListElement = null;

function showCommandList(sessionId) {
	
	if (originalCommandListElement != null) {
		originalCommandListElement.classList.add('hidden');
		if (originalCommandListElement == document.getElementById(sessionId)) {
			originalCommandListElement = null;
			return;
		}
	}
	
	let commandListElement = document.getElementById(sessionId);
	commandListElement.classList.remove('hidden');
	
	originalCommandListElement = commandListElement;
	
}

function banMember(sessionId) {
	
	stompClient.send('/pub/usr/chat/banMember',
	    {},
	    JSON.stringify({
	        'chatRoomId' : chatRoomId,
	        'sessionId' : sessionId,
	        'messageType' : 'BAN'
	    })
	)
	
}

//	비동기로 채팅방 정보를 받으며 클라이언트가 퇴장 했다는 문구가 나올 때마다 실행된다.
//	퇴장한 멤버가 방장이면 입장해 있는 멤버 중 가장 빨리 들어온 멤버가 자동으로 방장이 됨
//	이때 채팅방에서 방장 닉네임이 바뀌어야 하므로 받아온 채팅방 정보로 채팅방의 방장 닉네임을 새로운 방장 닉네임으로 변경
function getChatRoom() {
	
	let host = $('#host');
	
	$.ajax({
        type: 'GET',
        url: '/usr/chat/getChatRoom',
        data: {
            'chatRoomId': chatRoomId
        },
        success: function (data) {
			let hostNickname = data.hostNickname;
			hostMemberId = data.memberId;
			document.querySelector('#host-member-id').value = data.memberId;
			host.empty();
			host.html('<div>방장 : ' + hostNickname + '</div>');
        }
    })
	
}

//	메시지 전송때는 JSON 형식의 메시지를 전달한다.
function sendMessage(event) {
	
    let messageContent = messageInput.value.trim();

    if (messageContent && stompClient) {
		
        let chatMessage = {
            'chatRoomId' : chatRoomId,
            'memberId' : memberId,
            'message' : messageContent,
            'memberNickname' : memberNickname,
            'messageType' : 'TALK'
        };

        stompClient.send('/pub/usr/chat/sendMessage', {}, JSON.stringify(chatMessage));
        
        messageInput.value = '';
        
    }
    
    event.preventDefault();
    
}

//	메시지를 받을 때도 마찬가지로 JSON 타입으로 받으며,
//	넘어온 JSON 형식의 메시지를 parse 해서 사용한다.
function onMessageReceived(payload) {
	
    let chat = JSON.parse(payload.body);
    
    let messageElement = document.createElement('li');
    
    let chatFormatRegDateElement = document.createElement('span');
	let chatFormatRegDateText = document.createTextNode(' [ ' + chat.formatRegDate + ' ] ');
	
	chatFormatRegDateElement.classList.add('text-sm');
	
	chatFormatRegDateElement.appendChild(chatFormatRegDateText);

    if (chat.messageType == 'ENTER' || chat.messageType == 'BAN') {
        messageElement.classList.add('event-message');
		messageElement.appendChild(chatFormatRegDateElement);
		getMemberList();
    } else if (chat.messageType == 'LEAVE') {
        messageElement.classList.add('event-message');
		messageElement.appendChild(chatFormatRegDateElement);
		getChatRoom();
		getMemberList();
    } else {
		
		if (memberId == chat.memberId) {
			messageElement.classList.add('me');
		} else {
			messageElement.classList.add('other');
		}
		
		let memberNicknameElement = document.createElement('span');
		let memberNicknameText = document.createTextNode(chat.memberNickname + ' 님의 말');
		
		memberNicknameElement.classList.add('font-semibold');
		
		memberNicknameElement.appendChild(memberNicknameText);
		messageElement.appendChild(memberNicknameElement);
		
		messageElement.appendChild(chatFormatRegDateElement);
		
    }
    
    let contentElement = document.createElement('p');
    let messageText = document.createTextNode(chat.message);
    
    contentElement.appendChild(messageText);
    
	messageElement.appendChild(contentElement);
	
    messageArea.appendChild(messageElement);
    
    //	스크롤바 하단으로 이동
    messageArea.scrollTop = messageArea.scrollHeight;
    
}

//	채팅방에서 새로고침하면 퇴장, 입장 반복되던 부분 안되게
window.onkeydown = function (event) {
	//	F5, Ctrl + F5, Ctrl + R (새로고침)
	if ((event.keyCode == 116) || (event.ctrlKey == true && event.keyCode == 82)) {
		event.stopPropagation();
		if (confirm('채팅방에서 나가시겠습니까?')) {
			location.href = '/usr/chat/chatRoomList';
		}
		return false;
	}
}

messageForm.addEventListener('submit', sendMessage, true);
exitButton.addEventListener('click', disconnect, true);
window.addEventListener('beforeunload', disconnect, true);
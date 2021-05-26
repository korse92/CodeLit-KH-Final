toastr.options.escapeHtml = true;
toastr.options.closeButton = true;
toastr.options.newestOnTop = false;
toastr.options.progressBar = true;

let ws = new SockJS("/codelit/stomp");
let stompClient = Stomp.over(ws);

//2.connect핸들러 작성. 구독
stompClient.connect({}, (frame) => {
	
	stompClient.subscribe("/topic/user", (frame) => {
		const msgObj = JSON.parse(frame.body);
		const {msgTitle, msgContent} = msgObj;
		toastr.info(msgContent, "[유저알림] "+msgTitle, {timeOut: 5000});
	});
		stompClient.subscribe("/topic", (message) => {
		toastr.info(message, "[새로운 공지] ", {timeOut: 5000});
	});
	
	stompClient.subscribe("/topic/teacher", (frame) => {
		const msgObj = JSON.parse(frame.body);
		const {msgTitle, msgContent} = msgObj;
		toastr.info(msgContent, "[강사알림] "+msgTitle, {timeOut: 5000});
	});
});

	function sendMessage(url){
	const $message = $("#msgContent");
	const $title = $("#msgTitle");
	
	const message = {
		msgTitle : $title.val(),
		msgContent : $message.val(),
		readYN : 'N'
	};
	
	stompClient.send(url, {}, JSON.stringify(message));
}
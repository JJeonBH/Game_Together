function lightDark(i) {
	
	let lightDarkIcon = $(i);
	let lightDarkMsg = $('.light-dark-msg');
	
	if(lightDarkIcon.hasClass('light')) {
		lightDarkIcon.removeClass('light fa-sun');
		lightDarkIcon.addClass('dark fa-moon');
		lightDarkMsg.empty();
		lightDarkMsg.append('Dark mode')
		$('html').css('background', 'rgba(0, 0, 0, 0.7)');
		$('body').css('color', 'white');
	} else {
		lightDarkIcon.removeClass('dark fa-moon');
		lightDarkIcon.addClass('light fa-sun');
		lightDarkMsg.empty();
		lightDarkMsg.append('Light mode')
		$('html').css('background', 'white');
		$('body').css('color', 'black');
	}
	
}
function lightDark(lD) {
	
	let lightDark = $(lD);
	
	if(lightDark.hasClass('light')) {
		lightDark.removeClass('light');
		lightDark.addClass('dark');
		lightDark.html('<i class="fa-solid fa-moon"></i><span class="light-dark-msg text-xs text-center bg-black text-white">Dark mode</span>');
		$('html').css('background', 'rgba(0, 0, 0, 0.8)');
	} else {
		lightDark.removeClass('dark');
		lightDark.addClass('light');
		lightDark.html('<i class="fa-solid fa-sun"></i><span class="light-dark-msg text-xs text-center bg-black text-white">Light mode</span>');
		$('html').css('background', 'rgba(66, 188, 245, 0.5)');
	}
	
}

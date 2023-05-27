function themeToggle() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		if (theme == 'light') {
			localStorage.setItem("theme", "night");
		} else {
			localStorage.setItem("theme", "light");
		}
		
		location.reload();
		
}

function themeInit() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		themeApplyTo(theme);
		
}

function themeApplyTo(themeName) {
	
		$('html').attr('data-theme', themeName);
		
		$('.theme-toggle-msg').empty();
		
		if (themeName == 'light') {
			$('.theme-toggle-msg').append('Light mode');
		} else {
			$('.theme-toggle-msg').append('Dark mode');
			$('.dropdown-content').css('background', '#221c75');
			$('.dropdown-content').css('color', '#ffffff');
		}
		
}

themeInit();
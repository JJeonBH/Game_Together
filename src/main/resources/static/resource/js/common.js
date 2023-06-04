function themeToggle() {
	
		const theme = localStorage.getItem("theme") ?? "light";
		
		if (theme == 'light') {
			localStorage.setItem("theme", "night");
		} else {
			localStorage.setItem("theme", "light");
		}
		
		themeInit();
		
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
			$('.dropdown-content').css('background', 'white');
			$('.dropdown-content').css('color', 'black');
		} else {
			$('.theme-toggle-msg').append('Dark mode');
			$('.dropdown-content').css('background', '#221c75');
			$('.dropdown-content').css('color', '#ffffff');
		}
		
}

function submitSearchForm(form) {
	
	form.summonerName.value = form.summonerName.value.trim();
	
	if (form.summonerName.value.length == 0) {
		alert("소환사명을 입력해주세요.");
		return;
	}
	
	form.submit();
	
}

themeInit();
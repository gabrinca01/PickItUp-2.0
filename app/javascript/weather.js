let date = document.getElementsByClassName(slideclass);
let time = document.getElementsByClassName(slideclass);



	//set_inteval(call_weather_api, 5000);

const settings = {
	"async": true,
	"crossDomain": true,
	"url": "https://weatherapi-com.p.rapidapi.com/future.json?q=London&dt=2022-12-25",
	"method": "GET",
	"headers": {
		"X-RapidAPI-Key": "dd42f26b3emshac94e324c873f7bp132f7cjsn86b7b4d80c16",
		"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
	}
};

$.ajax(settings).done(function (response) {
	console.log(response);
});
var url_string = window.location.href;
var url = new URL(url_string);

$('#challenge_temp_date_3i').on('change', get_weather)
$('#challenge_temp_time_4i').on('change', get_weather)

function get_weather(){
	let year = document.getElementById("challenge_temp_date_1i").value;
	let month = "0"+document.getElementById("challenge_temp_date_2i").value;
	let day = document.getElementById("challenge_temp_date_3i").value;
	let hour = document.getElementById("challenge_temp_time_4i").value;
	let minute = document.getElementById("challenge_temp_time_5i").value;
	let lat=url.searchParams.get('lat');
	let lng = url.searchParams.get('lng');

	const settings = {
		"async": true,
		"crossDomain": true,
		"url": "https://dark-sky.p.rapidapi.com/"+lat+','+lng+','+year+'-'+month+'-'+day+'T'+hour+':'+minute+":00",
		"method": "GET",
		"headers": {
			"X-RapidAPI-Key": "dd42f26b3emshac94e324c873f7bp132f7cjsn86b7b4d80c16",
			"X-RapidAPI-Host": "dark-sky.p.rapidapi.com"
		}
	};

	$.ajax(settings).done(function (response) {
		console.log(response);
		let icona = response.currently.icon;
		switch (icona) {
		  case 'partly-cloudy-day':
		    document.getElementById('weather').innerHTML="<div  id = 'part_cloud' class= 'part_cloud_c' style='display:block;'>";
		    break;
		  case 'partly-cloudy-night':
		    document.getElementById('weather').innerHTML="<div  id = 'part_cloud' class= 'part_cloud_c' style='display:block;'>";
		    break; 
		  case 'clear-day':
			document.getElementById('weather').innerHTML="<div  id = 'sun' class= 'sun_c' style='display:block;'>";
		  	console.log("sun");
		  	break;
		  case 'clear-night':
			document.getElementById('weather').innerHTML="<div  id = 'sun' class= 'sun_c' style='display:block;'>";
			console.log("sun");
			break;
		  case 'cloudy':
		    document.getElementById('weather').innerHTML="<div  id = 'cloud' class= 'cloud_c' style='display:block;'>";
		    break;
		   case 'rain':
			document.getElementById('weather').innerHTML="<div  id = 'rain' class= 'rain_c' style='display:block;'>";
		   	break;
		  default:
		    console.log('Sorry, we are out of icons.');
		}
	
	});
}
get_weather();
//set_interval(get_weather,3000);
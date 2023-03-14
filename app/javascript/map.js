let map;

function initMap() {
    const myLatlng = { lat: 41.9028, lng: 12.4964 };
     map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: myLatlng,
      mapTypeId: 'terrain'
    }); 
    map.setClickableIcons(false);

    var radius=200;

    const challenge_zone = new google.maps.Circle({
        strokeColor: "red",
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: "darkred",
        fillOpacity: 0.35,
        map:map,
        radius: radius,
        editable : true,
        draggable:false,
      }); 
    const infowindow = new google.maps.InfoWindow();
    const marker = new google.maps.Marker({
          map:map,
        });
    map.addListener('click', function(e) {
        challenge_zone.setMap(null);
        marker.setMap(null);
        infowindow.setMap(null);
        var lat = e.latLng.lat();
        var lng = e.latLng.lng();
        var p=new google.maps.LatLng(lat, lng);
        
        
        challenge_zone.setEditable(true);
        challenge_zone.setMap(map);
        challenge_zone.setCenter(p); 
        challenge_zone.addListener('click',() =>  {
          challenge_zone.setEditable(false);
          const contentString ='<div id="create_challenge"><a href="../challenges/new">Create Challenge Here</a>' + 
        "</div>";
        infowindow.setContent(contentString);
          
          marker.setMap(map);
          marker.setPosition(p);
          infowindow.open({
            anchor: marker,
            map:map,
            shouldFocus: false,
          }); 
        });
        
    });
    challenge_zone.addListener('radius_changed',() =>{
            radius=challenge_zone.getRadius();
        });
   
    infowindow.addListener('closeclick', ()=>{
          // Handle focus manually.
    });
    challenge_zone.addListener('dblclick',() =>{
          challenge_zone.setMap(null);
          infowindow.setMap(null);
          marker.setMap(null);
      });
  }   
window.initMap = initMap;
let camera_button = document.querySelector("#start-camera");
let video = document.querySelector("#video");
let click_button = document.querySelector("#click-photo");
let canvas = document.querySelector("#canvas");
let upload_button = document.querySelector("#upload");

camera_button.addEventListener('click', async function() {
    let stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
  video.srcObject = stream;
});

click_button.addEventListener('click', function() {
    canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
    var image_data_url = canvas.toDataURL('image/jpeg');
    // data url of the image
    upload_button.addEventListener('click', function(){
       let images = document.querySelector("#post_images");
       if(!images.value[0] == '#') {
            let old = images.value
            images.value =old + image_data_url;
        }else
            images.value = image_data_url
        
    });
    console.log(image_data_url);
});

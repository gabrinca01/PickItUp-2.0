$('#suggestion_b').on('click', get_suggestion)


function get_suggestion(){

    const questions = ["What is the distance between the earth and the sun in apples","roll a d20"]
    var question = questions[Math.floor(Math.random()*questions.lenght)]

    const settings = {
        "async": true,
        "crossDomain": true,
        "url": "https://you-chat-gpt.p.rapidapi.com/",
        "method": "POST",
        "headers": {
            "content-type": "application/json",
            "X-RapidAPI-Key": "17f85b831cmsh2c8d4e31a76ab27p1fc81cjsnf7593b684a89",
            "X-RapidAPI-Host": "you-chat-gpt.p.rapidapi.com"
        },
        "processData": false,
        "data": {
            "question": question,
            "max_response_time": 30
        }
    };
    
    $.ajax(settings).done(function (response) {
        console.log(response);
        document.getElementById("suggestion").innerHTML = response.content
    });
}
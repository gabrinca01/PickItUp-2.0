$('#suggestion_b').on('click', get_suggestion)


function get_suggestion(){

    const questions = ["How much the maximum temperature changed compared to last year?","What we can do in everyday life to be as ecologically friendly as possible?","Tell me one of the most dangerous habits for the environment","Tell me one way pollution affects the human body","Tell me one of the most valuable discoveries in the fight against pollution"]
    var question = questions[Math.floor(Math.random()*questions.lenght)]

    const settings = {
        "async": true,
        "crossDomain": true,
        "url": "https://you-chat-gpt.p.rapidapi.com",
        "method": "POST",
        "headers": {
            "content-type": "application/json",
            "X-RapidAPI-Key": "17f85b831cmsh2c8d4e31a76ab27p1fc81cjsnf7593b684a89",
            "X-RapidAPI-Host": "you-chat-gpt.p.rapidapi.com"
        },
        "processData": false,
        "data": {
            "question": question,
            "max_response_time": 10
        }
    };
    
    $.ajax(settings).done(function (response) {
        console.log(response);
        document.getElementById("suggestion").innerHTML = response.content
    });
}
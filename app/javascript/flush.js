$('#sub').on('click',flush);

function flush(){
  console.log("ciao");
  document.getElementById("f").submit();
  document.getElementById("chat-text").value = '';
}

/*$('#sub').on('click',flush);

function flush(){
  console.log("ciao");
  document.getElementById("f").submit();
  document.getElementById("chat-text").value = '';
}*/

const btn = document.getElementById('sub');

btn.addEventListener('click', function handleClick(event) {
  // 👇️ if you are submitting a form (prevents page reload)
  event.preventDefault();

  const text = document.getElementById('chat-text');

  // Send value to server
  console.log(text.value);
    document.getElementById("f").submit();
  // 👇️ clear input field
  
  text.value = '';
});
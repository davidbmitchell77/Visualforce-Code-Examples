// iFrame/parent window  2-way communication sample code:

//parent window sends message to remote site through the iFrame:
document.getElementById("iframe").contentWindow.postMessage(
        document.getElementById("message").value,
        "http://anotherdomain.com" // restrict message handling to this remote URL
);

// remote site handles the message with:
window.onmessage = function(e){
  // if not the authorized domain, do not process the message
  if ( e.origin !== "http://html5demos.com" ) {
    return;
  }

  // display the message sent from parent window:
  document.getElementById("test").innerHTML = e.origin + " said: " + e.data;
};

//  Visualforce markup for iframe useage:
  <apex:page controller="iframeController" sidebar="false">
    <apex:inputText id="message"/>
    <iframe src="{!url.url__c}" scrolling="true" id="iframe" width="100%" height="100%"/>
  </apex:page>

// Visualforce markup for iframe w/ auto-resizing:
  <apex:page controller="iframeController" sidebar="false">
    <apex:inputText id="message"/><p/>
    <apex:iframe src="https://trailhead.salesforce.com/" id="iframe" />
    <script>document.getElementById('iframe').height = window.innerHeight - 220;</script>
  </apex:page>

/* ----------------------------------------------------------- */
/* iFrame/parent window  2-way communication sample code:      */
/* ----------------------------------------------------------- */
// parent window sends message to remote site through the iFrame:
document.getElementById("iframe").contentWindow.postMessage(
    document.getElementById("message").value,  // text from parent window text box
    "http://anotherdomain.com"   // restrict message handling to this remote domain
);

// remote site handles the message:
window.onmessage = function(e) {
  // if message not sent fom authorized domain, do not process:
  if ( e.origin !== "http://html5demos.com" ) {
    return;
  }
  // display message sent from parent window in the child iframe:
  document.getElementById("test").innerHTML = e.origin + " said: " + e.data;
};

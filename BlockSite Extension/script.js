document.addEventListener("DOMContentLoaded", function(event) {
    console.log("dom content loaded");
    safari.extension.dispatchMessage("shouldBlock");
});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    console.log("handle message");
    if (window.top === window) {
        window.location.href = "http://localhost";
    }
}

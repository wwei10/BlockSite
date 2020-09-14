document.addEventListener("DOMContentLoaded", function(event) {
    console.log("dom content loaded");
    safari.extension.dispatchMessage("shouldBlock");
});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    console.log("handle message");
    if (window.top === window) {
        let time = parseInt(event.message["time"])
        console.log(parseInt(time));
        window.location.href = "https://blocksite-gcloud-app.wl.r.appspot.com/" + time;
    }
}

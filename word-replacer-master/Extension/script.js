document.addEventListener("DOMContentLoaded", function(event) {
    safari.self.addEventListener("message", handleMessage);
    safari.extension.dispatchMessage("WR_LOADED");
});

function handleMessage(e) {
    if (e.name == "WR_REPLACE") {
        const originalWord = e.message['WR_ORIGINAL'];
        const newWord = e.message['WR_NEW'];

        if (originalWord.length === 0) {
            return;
        }
        
        document.body.innerHTML = document.body.innerHTML.replace(originalWord, newWord);
    } 
}

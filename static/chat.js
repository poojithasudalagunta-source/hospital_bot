async function sendMessage() {

    const input = document.getElementById("userInput");
    const chatbox = document.getElementById("chatbox");

    const message = input.value.trim();
    if (!message) return;

    // ---------- USER BUBBLE ----------
    chatbox.innerHTML += `
        <div style="text-align:right; margin:10px 0">
            <span style="
                background:#007bff;
                color:white;
                padding:10px 14px;
                border-radius:14px 14px 4px 14px;
                display:inline-block;
                max-width:70%;
                word-wrap:break-word;">
                ${message}
            </span>
        </div>
    `;

    input.value = "";

    // ---------- TYPING INDICATOR ----------
    const typingId = "typing_" + Date.now();
    chatbox.innerHTML += `
        <div id="${typingId}" style="text-align:left; margin:10px 0">
            <span style="
                background:#e9ecef;
                padding:8px 12px;
                border-radius:14px 14px 14px 4px;
                display:inline-block;">
                ⏳ Typing...
            </span>
        </div>
    `;

    chatbox.scrollTop = chatbox.scrollHeight;

    try {

        const response = await fetch("http://127.0.0.1:5000/chat", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                message: message,
                patient_id: 1
            })
        });

        const data = await response.json();

        // remove typing
        const typingElement = document.getElementById(typingId);
        if (typingElement) typingElement.remove();

        // ---------- BOT REPLY ----------
        chatbox.innerHTML += `
            <div style="text-align:left; margin:10px 0">
                <span style="
                    background:#e9ecef;
                    color:black;
                    padding:10px 14px;
                    border-radius:14px 14px 14px 4px;
                    display:inline-block;
                    max-width:70%;
                    word-wrap:break-word;">
                    ${data.reply || "No reply"}
                </span>
            </div>
        `;

        // ---------- SMART LIST DISPLAY ----------
        if (data.data && Array.isArray(data.data) && data.data.length > 0) {

            chatbox.innerHTML += `<div style="margin:6px 0 10px 0">`;

            data.data.forEach(item => {
                chatbox.innerHTML += `
                    <button onclick="quickSend('${item.replace(/'/g,"")}')"
                        style="
                        display:block;
                        background:white;
                        border:1px solid #007bff;
                        color:#007bff;
                        padding:6px 10px;
                        margin:4px 0;
                        border-radius:10px;
                        cursor:pointer;
                        transition:0.2s;">
                        ➤ ${item}
                    </button>
                `;
            });

            chatbox.innerHTML += `</div>`;
        }

        // ---------- SUCCESS ----------
        if (data.type === "booking" || data.type === "success") {
            chatbox.innerHTML += `
                <div style="
                    color:green;
                    font-weight:bold;
                    margin:6px 0;">
                    ✔ Done successfully
                </div>
            `;
        }

        // ---------- ERROR ----------
        if (data.type === "error") {
            chatbox.innerHTML += `
                <div style="
                    color:red;
                    margin:6px 0;">
                    ⚠ ${data.reply}
                </div>
            `;
        }

    } catch (err) {

        const typingElement = document.getElementById(typingId);
        if (typingElement) typingElement.remove();

        chatbox.innerHTML += `
            <div style="color:red;margin:8px 0">
                ⚠ Server not reachable
            </div>
        `;
    }

    chatbox.scrollTop = chatbox.scrollHeight;
}


// ---------- QUICK BUTTON CLICK ----------
function quickSend(text){
    document.getElementById("userInput").value = text;
    sendMessage();
}


// ---------- ENTER KEY ----------
document.getElementById("userInput").addEventListener("keypress", function(e) {
    if (e.key === "Enter") sendMessage();
});
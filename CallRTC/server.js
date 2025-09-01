//
//  server.js
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//

// Simunado o socket para o peer


const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 8080 });

wss.on("connection", ws => {
  console.log("🔌 New client connected");

  ws.on("message", message => {
    console.log("📩 Received:", message.toString());

    wss.clients.forEach(client => {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
        client.send(message.toString());
      }
    });
  });

  ws.on("close", () => {
    console.log("❌ Client disconnected");
  });
});

console.log("✅ Signaling server running on ws://localhost:8080");


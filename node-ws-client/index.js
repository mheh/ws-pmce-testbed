import WebSocket from "ws";

const ws = new WebSocket("ws://localhost:8080/test");

ws.on("error", console.error);

ws.on("open", function open() {
  let messageString = "";
  ws.send(messageString);
});

ws.on("message", function(event) {
  console.log(event);
});
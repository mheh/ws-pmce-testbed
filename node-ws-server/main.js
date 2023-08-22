// Importing the required modules

import { WebSocketServer } from "ws";
const toBytes = (string) => Array.from(Buffer.from(string, "utf8"));

// Creating a new websocket server
const pmceOpts = {
  zlibDeflateOptions: {
    // See zlib defaults.
    chunkSize: 1024,
    memLevel: 7,
    level: 5,
  },
  zlibInflateOptions: {
    chunkSize: 1024,
  },
  // Other options settable:
  // clientNoContextTakeover: true, // Defaults to negotiated value.
  // serverNoContextTakeover: true, // Defaults to negotiated value.
  serverMaxWindowBits: 15, // Defaults to negotiated value.
  // Below options specified as default values.
  //concurrencyLimit: 10, // Limits zlib concurrency for perf.
  threshold: 16, // Size (in bytes) below which messages
  // should not be compressed if context takeover is disabled.
};

/**
 * Argument Parser for command line
 *
 * Main options:
 * <none>
 *        - use default options
 * --help
 *        - print help
 *
 * Zlib options:
 * --zlib_memory_level <int>
 *        - zlib memory level (default 7)
 * --zlib_compression_level <int>
 *        - zlib compression level (default 5)
 */
function parseArgs() {}

// MARK: - WebSocketServer Configuration
const wss = new WebSocketServer({ port: 8080, perMessageDeflate: pmceOpts });

// Creating connection using websocket
wss.on("connection", (ws, req) => {
  ws.binaryType = "arraybuffer";

  console.log("req.headers = " + JSON.stringify(req.headers, null, 2));

  // sending message to client
  var greeting = "Welcome, you are conntected!";
  greeting = greeting + greeting;

  //force binary frame
  var msg = toBytes(greeting);
  console.log(
    "sending greeting as text " + greeting + " " + greeting.length + " bytes"
  );
  ws.send(greeting);

  console.log("sending greeting as bin " + msg + " " + msg.length + " bytes");
  ws.send(msg);

  //on message from client
  ws.on("message", (event) => {
    if (event instanceof ArrayBuffer) {
      // binary frame
      console.log("received bin frame: " + event.byteLength + " bytes.");
    } else {
      // text frame
      console.log("received text frame:" + event.length + " bytes");
    }
  });

  // handling what to do when clients disconnects from server
  ws.on("close", () => {
    console.log("the client has DISCONNECTED.");
  });
  // handling client connection error
  ws.onerror = function (e) {
    console.log("Some Error occurred " + JSON.stringify(e, null, 2));
  };
});
console.log("The WebSocket server is running on port 8080");
console.log("with " + JSON.stringify(pmceOpts, null, 2));

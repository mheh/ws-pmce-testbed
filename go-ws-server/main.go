package main

import (
    "fmt"
    "strconv"
    "log"
    "net/http"
    "github.com/gorilla/websocket")

func homePage(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Home Page")
}

func wsEndpoint(w http.ResponseWriter, r *http.Request) {
    fmt.Println(r)
	// We'll need to define an Upgrader
// this will require a Read and Write buffer size
		var upgrader = websocket.Upgrader{
    		ReadBufferSize:  1024,
    		WriteBufferSize: 1024,
            EnableCompression: true,
		}
	    upgrader.CheckOrigin = func(r *http.Request) bool { return true }

	 // upgrade this connection to a WebSocket
    // connection
    ws, err := upgrader.Upgrade(w, r, nil)
    if err != nil {
        log.Println(err)
    }
	reader(ws)

}

func setupRoutes() {
    http.HandleFunc("/", homePage)
    http.HandleFunc("/test", wsEndpoint)
}

func main() {
    fmt.Println("gorilla ws server testbed on 8080")
    setupRoutes()
    log.Fatal(http.ListenAndServe(":8080", nil))
}

func reader(conn *websocket.Conn) {
    for {
    // read in a message
        messageType, p, err := conn.ReadMessage()
        if err != nil {
            log.Println(err)
            return
        }
        fmt.Println("received mesage type " + strconv.Itoa(messageType))
    
    // print out that message for clarity
        
        fmt.Println("echoing message " + strconv.Itoa(messageType))
        if err := conn.WriteMessage(messageType, p); err != nil {
            log.Println(err)
            return
        }

    }
}
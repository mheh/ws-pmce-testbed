import Vapor

/// To connect to WebSocket server with PMCE if supported:
public func configure(_ app: Application) async throws {

    /// Server to connect to, such as vapor-ws-server
    let testURL = "ws://localhost:8080/test"
    try routes(app)
    
    /// Create a config to requeset be used for communications.
    let config = PMCE.PMCEConfig(config: .init(agreedParams: .init()))
    print("vapor_ws_client: asking for PMCE \(config)!")
    
            try await WebSocket.connect(to: testURL,
                                        configuration: .init(pmceConfig:config),
                                        on: app.eventLoopGroup) { (ws) in
                
                print("vapor_ws_client: CONNECTED to \(testURL)!")
                if let p = ws.pmce {
                    print("vapor_ws_client: with \(p)")
                }else {
                    print("vapor_ws_client: with NO PMCE")
                }
                
                /// If the server accepted our connection should be compressed now.
                /// * You can inspect _ws.pmce_ to see its status or use WireShark to see over the wire.
            
                ws.eventLoop.execute {
                    print("vapor_ws_client: adding TEXT, BIN handlers...")
                    ws.onText ({ ws, text in
                        
                        print("vapor_ws_client: Received \(text.count) bytes of TEXT")
                      
                    })
                    
                    ws.onBinary ({ ws, bin in
                        
                        print("vapor_ws_client: Received \(Data(buffer:bin).count) bytes as binary")
                    })
                    // in another PR tangle with this one
                    //ws.onclose ()
                    print("vapor_ws_client: preparing test message...")
                    let msg = "Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!"
                    
                    // send as byte buffer to force binary
                    let binBuff = ByteBuffer(string:msg)
                    
                    print("vapor_ws_client: sending binary message: \(Data(buffer:binBuff).count) bytes.")
                    ws.send(binBuff)
                    
                    print("vapor_ws_client: sending text message: \(msg.count) bytes.")
                    ws.send(msg)
                }
            
            }
    
}

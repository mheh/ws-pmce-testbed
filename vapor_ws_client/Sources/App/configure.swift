import Vapor

/// To Connect to Compressed Websockets...
public func configure(_ app: Application) async throws {

    try routes(app)
    
    /// Create a config.
    let config = PMCE.DeflateConfig(clientCfg: .init(takeover:.noTakeover,
                                                     maxWindowBits: 15 ),
                                    serverCfg: .init(takeover: .noTakeover,
                                                     maxWindowBits: 15))
            
            let wsURL = "ws://localhost:8080/test"
            
            /// Connect with the client api with the config headers (and any others you may want).
            try await WebSocket.connect(to: wsURL ,
                                        headers: config.headers(),
                                        on: app.eventLoopGroup) { (ws) in
                
                print("tbclient: CONNECTED to \(wsURL)!")

                /// If the server accepted our connection should be compressed now.
                /// you can inspect pmce to see its success or wireshark.
            
                ws.eventLoop.execute {
                    ws.onText ({ ws, text in
                        
                        print("tbclient: Received \(text.count) bytes of TEXT")
                        print("----")
                        print(text)
                        print("----")
                    })
                    
                    ws.onBinary ({ ws, bin in
                        
                        print("tbclient: Received \(Data(buffer:bin).count) bytes as binary")
                        print("----")
                        print(Data(buffer:bin))
                        print("----")
                    })
                }
            
                let msg = "Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!"
                
                //        // send as byte buffer to force binary
                let binBuff = ByteBuffer(string:msg)
                
                print("tbclient: sending binary message: \(Data(buffer:binBuff).count) bytes")
                ws.send(binBuff)
                
                print("tbclient: sending text message: \(msg.count) bytes")
                ws.send(msg)
            }
    
}

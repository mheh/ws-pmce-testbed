//import Vapor
//
//extension UInt8?:LosslessStringConvertible, CustomStringConvertible {
//    public init?(_ description: String) {
//        self = UInt8(description) ?? nil
//    }
//    
//    public var description: String {
//        ""
//    }
//}
//
//final class AsyncConnectCommand: AsyncCommand {
//    
//    static let name = "con"
//    
//    struct Signature: CommandSignature {
//            
//        @Argument<String>(name:"url")
//        var url: String
//        
//        @Flag(name: "client_no_context_takeover",
//                short: nil,
//                help: "client will reset window for each message")
//        var cnct:Bool
//        
//        @Flag(name: "server_no_context_takeover",
//                short: nil,
//                help: "server will reset window for each message")
//        var snct:Bool
//        
//        @Option(name: "client_max_window_bits",
//                help: "The maximum size of window as a power of 2 for the client. (8...15) are valid.")
//        var cmwb:UInt8?
//        
//        @Option(name: "server_max_window_bits",
//                help: "The maximum size of window as a power of 2 for the server. (8...15) are valid.")
//        var smwb:UInt8?
//    }
//    
//    var help: String {
//        "Connects to url with provided PMCE options."
//    }
//    
//    func asyncRun(
//        using context: CommandContext,
//        signature: Signature
//    ) async throws {
////        context.console.print("\(context) \(signature)")
//        
//        context.console.info("<test> \(signature.cnct) \(signature.snct) \(signature.smwb) \(signature.cmwb)")
//
//        let cmwb = signature.cmwb
//        let smwb = signature.smwb
//        let cnct:PMCE.PMCEConfig.TakeoverMode = signature.cnct ? .takeover : .noTakeover
//        
//        let snct:PMCE.PMCEConfig.TakeoverMode = signature.snct ? .takeover : .noTakeover
//        
//        let c = PMCE.PMCEConfig(clientCfg: .init(takeover:cnct,
//                                                 maxWindowBits: cmwb ),
//                                serverCfg: .init(takeover: snct,
//                                                 maxWindowBits: smwb))
//        
//      
//        let wscfg = WebSocketClient.Configuration(withPMCE: pmce)
//        let wsURL = "ws://localhost:8080/test"
//        
//        /// Pass the headers to the websocket so it has the sec websocket xt
//        /// TODO would like to pass only PMCE and generate headers when neeed
//        try await WebSocket.connect(to: wsURL ,
//                                    headers: c.headers(),
//                                    configuration: wscfg,
//                                    on: context.application.eventLoopGroup) { (ws) in
//            context.console.info("CONNECTED")
//            print("tbclient: CONNECTED to \(wsURL)!")
//            
//            ws.onText { ws, text in
//                
//                print("tbclient: Received \(text.count) bytes of TEXT")
//                print("----")
//                print(text)
//                print("----")
//            }
//            
//            ws.onBinary { ws, bin in
//                
//                print("tbclient: Received \(Data(buffer:bin).count) bytes as binary")
//                print("----")
//                print(Data(buffer:bin))
//                print("----")
//            }
//            
//            let msg = "Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!Supsupsupsupuspuspuspuspsusupsuspsuspuspuspuspuspuspuspuspusupspusupsupspuspusupspuspuspuspuspusupsupspuspuspuspupuspuspuspusupspuspusupspusupspuspu!"
//            
//            //        // send as byte buffer to force binary
//            let binBuff = ByteBuffer(string:msg)
//            
//            print("tbclient: sending binary message: \(Data(buffer:binBuff).count) bytes")
//            ws.send(binBuff)
//            print("tbclient: sending text message: \(msg.count) bytes")
//            ws.send(msg)
//            
//        }
//    }
//    
//}
//

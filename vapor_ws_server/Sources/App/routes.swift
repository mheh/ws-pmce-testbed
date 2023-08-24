import Vapor
/// To Serve Compressed Websocket Frames ...
///
func routes(_ app: Application) throws {
    
    let longHello = "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello"
    
    /// Configure your personal zlib settings and parameters to agree to,
    /// The plain init should accept any valid request from the client.
    /// auto negotioation is wip
    let conf:PMCE.PMCEConfig = .init(config: .init(agreedParams: .init() ,
                                                   zlib: .defaultConfig()))
    /// Pass in a pmce config to this route builder.
    app.webSocket([PathComponent(stringLiteral: "test-pmce")],
                  pmce:conf) { req, webSoc in
        
        // Our WebSocket's PMCE is configured and it will handle compressing
        // and decompressing behind the scenes for text and binary messages.
        // wireshark is the beset way to verify usage.
        req.logger.info("client connected on test-pmce")
        
        webSoc.eventLoop.execute {
            req.logger.info("Request upgraded with headers:\n\(req.headers) ")
            let pmceMsg = (webSoc.pmce == nil ? "with" : "without") + " per-message compression extensions."
            req.logger.info("\(pmceMsg)")
            
            req.logger.info("Registering handlers for text, binary messages..")
          
            webSoc.onText({ ws, text in
                req.logger.info("vapor-ws-server: Received text message: \(text.count) bytes \(text)")
            })
            
            webSoc.onBinary( { ws, bin in
    
                app.logger.info("vapor-ws-server: got bin (as String):\(bin.readableBytes) bytes")
            })
            req.logger.info("registered.")
            
            req.logger.info("saying hello...")
            webSoc.send("hello")
            
            req.logger.info("saying long hello...")
            webSoc.send(longHello)
        }
    }
    
    app.webSocket("test-no-pmce") { req, webSoc in
        
        req.logger.info("client connected on test-no-pmce.")
        webSoc.eventLoop.execute {
            req.logger.info("Request upgraded to WebSocket with headers:\n\(req.headers) ")
            let pmceMsg = (webSoc.pmce == nil ? "with" : "without") + " per-message compression extensions."
            req.logger.info("\(pmceMsg)")
            
            req.logger.info("Registering handlers for text, binary messages..")
          
            webSoc.onText({ ws, text in
                req.logger.info("vapor-ws-server: Received text message: \(text.count) bytes")
            })
            
            webSoc.onBinary( { ws, bin in
    
                app.logger.info("vapor-ws-server: got bin (as String):\(bin.readableBytes) bytes")
            })
            
            req.logger.info("registered.")
            
            req.logger.info("saying hello...")
            webSoc.send("Hello")
            
            req.logger.info("saying long hello...")
            webSoc.send(longHello)
        }
    }
   
}

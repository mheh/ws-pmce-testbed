import Vapor
/// To Serve Compressed Websocket Frames ...
///
func routes(_ app: Application) throws {
    typealias ClientConfig = PMCE.DeflateConfig.ClientConfig
    typealias ServerConfig = PMCE.DeflateConfig.ServerConfig
    
    // create a PMCE deflate config to create headers.
    let supportedConfig = PMCE.DeflateConfig(clientCfg: .init(takeover: .noTakeover,
                                                              maxWindowBits: 15),
                                             serverCfg: .init(takeover: .noTakeover, maxWindowBits: 15))
    
    print("Upported headers \(supportedConfig.headers())")

    /// we use this shouldUpgrade to inject our PMCE headers into the Websocket lifecyle
    app.webSocket("test",
                  maxFrameSize: WebSocketMaxFrameSize.default) { req in
        // here we decide if we should upgrade so this is where we negotioate the compression strategy.
        // RFC isnt so clear on how this is determined really.
        let requestedConfigs = PMCE.DeflateConfig.configsFrom(headers: req.headers)
        
        app.logger.info("tbserver: - should ugrade callback requested \(requestedConfigs.debugDescription)")
        
        // for now tell the client what to use and ignore their request.
        // whatever headers we pass here will be used to configure PMCE.
        // this isnt ideal as well should really only return these if the client
        // requested PMCE.
        return supportedConfig.headers()
        
    } onUpgrade: { req, webSoc in
        
        // Our WebSocket's PMCE is configured and it will handle compressing
        // and decompressing behind the scenes for text and binary messages.
        webSoc.eventLoop.execute {
            req.logger.info("\(String(describing: webSoc.pmce))")
          
            webSoc.onText({ ws, text in
                print("tbserver: Received text message: \(text)")
            })
            
            webSoc.onBinary( { ws, bin in
    
                app.logger.info("tbserver: got bin (as String):\(String(buffer: bin))")
            })
        }
        

    }
    
    app.logger.info("supported PMCE for websockets \(supportedConfig)")
}

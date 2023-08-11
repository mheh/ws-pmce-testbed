import Vapor
/// To Serve Compressed Websocket Frames ...
///
func routes(_ app: Application) throws {
    
    typealias ClientConfig = PMCE.PMCEConfig.DeflateConfig
    typealias ServerConfig = PMCE.PMCEConfig.DeflateConfig
    

    // create a PMCE deflate config to create headers.
    let supportedConfig = PMCE.PMCEConfig(clientCfg: .init(takeover: .noTakeover,
                                                              maxWindowBits: 15,
                                                              zlib: .midRamMidComp),
                                             serverCfg: .init(takeover: .noTakeover,                       maxWindowBits: 15,
                                                              zlib: .midRamMidComp))
    
    print("Supported PMCE config headers \(supportedConfig.headers())")

    /// we use this shouldUpgrade to inject our PMCE headers into the Websocket lifecyle
    app.webSocket("test",
                  maxFrameSize: WebSocketMaxFrameSize.default) { req in
        /// Grab the configs from the client if present.
        let requestedConfigs = PMCE.PMCEConfig.configsFrom(headers: req.headers)
        
        app.logger.info("vapor_ws_server: - should ugrade callback requested configs  \(requestedConfigs.debugDescription)")
        
       /// These headers configure the PMCE on the websocket passed to onUpgrade.
        /// If they passed a pmce config we can parse, return it in to accept the config.
        
        return requestedConfigs.isEmpty ? req.headers : supportedConfig.headers(xt:true)
    } onUpgrade: { req, webSoc in
        
        // Our WebSocket's PMCE is configured and it will handle compressing
        // and decompressing behind the scenes for text and binary messages.
        // If no headers were returned above, no compression will be used.
        // wireshark is the beset way to verify usage.
        webSoc.eventLoop.execute {
            req.logger.info("Request upgraded to WebSocket with headers:\n\(req.headers) ")
            if let pmce = webSoc.pmce {
                pmce.logging = true
                req.logger.info("with per-message compression extensions.\n\(pmce.description)")
            }else {
                req.logger.info("without per-message compression extensions.")
            }
            req.logger.info("Registering handlers for text, binary messages..")
          
            webSoc.onText({ ws, text in
                req.logger.info("vapor-ws-server: Received text message: \(text.count) bytes")
            })
            
            webSoc.onBinary( { ws, bin in
    
                app.logger.info("vapor-ws-server: got bin (as String):\(bin.readableBytes) bytes")
            })
        }
    }
    
    app.logger.info("vapor-ws-server: supported PMCE for websockets \(supportedConfig)")
}

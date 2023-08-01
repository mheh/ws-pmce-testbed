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
    
    print("Supported PMCE config headers \(supportedConfig.headers())")

    /// we use this shouldUpgrade to inject our PMCE headers into the Websocket lifecyle
    app.webSocket("test",
                  maxFrameSize: WebSocketMaxFrameSize.default) { req in
        /// Grab the configs from the client if present.
        let requestedConfigs = PMCE.DeflateConfig.configsFrom(headers: req.headers)
        
        app.logger.info("vapor_ws_server: - should ugrade callback requested configs  \(requestedConfigs.debugDescription)")
        
       /// These headers configure the PMCE on the websocket passed to onUpgrade.
        /// If they passed a pmce config we can parse, return it in to accept the config. 
        return requestedConfigs.first?.headers() ?? [:]
    } onUpgrade: { req, webSoc in
        
        // Our WebSocket's PMCE is configured and it will handle compressing
        // and decompressing behind the scenes for text and binary messages.
        // If no headers were returned above, no compression will be used.
        // wireshark is the beset way to verify usage.
        webSoc.eventLoop.execute {
            req.logger.info("Request upgraded to WebSocket \(req.headers) ")
            if webSoc.pmce != nil {
                webSoc.pmce?.logging = true
                req.logger.info("with PMCE.\n\(webSoc.pmce?.description)")

            }else {
                req.logger.info("without PMCE")
            }
            req.logger.info("Registering handlers.")
          
            webSoc.onText({ ws, text in
                print("vapor-ws-server: Received text message: \(text.count) bytes")
            })
            
            webSoc.onBinary( { ws, bin in
    
                app.logger.info("vapor-ws-server: got bin (as String):\(bin.readableBytes) bytes")
            })
        }
    }
    
    app.logger.info("supported PMCE for websockets \(supportedConfig)")
}

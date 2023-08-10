import Vapor
/// To Serve Compressed Websocket Frames ...
///
func routes(_ app: Application) throws {
    
    typealias ClientConfig = PMCE.PMCEConfig.DeflateConfig
    typealias ServerConfig = PMCE.PMCEConfig.DeflateConfig
    

    // create a PMCE deflate config to create headers.
    let supportedConfig = PMCE.PMCEConfig(clientCfg: .init(takeover: .noTakeover,
                                                              maxWindowBits: 15,
                                                              zlib: .maxRamMaxComp),
                                             serverCfg: .init(takeover: .noTakeover,                       maxWindowBits: 15,
                                                              zlib: .maxRamMaxComp))
    
    print("Supported PMCE config headers \(supportedConfig.headers())")

    /// we use this shouldUpgrade to inject our PMCE headers into the Websocket lifecyle
    app.webSocket("test",
                  maxFrameSize: WebSocketMaxFrameSize.default) { req in
        /// Grab the configs from the client if present.
        let requestedConfigs = PMCE.PMCEConfig.configsFrom(headers: req.headers)
        
        app.logger.info("vapor_ws_server: - should ugrade callback requested configs  \(requestedConfigs.debugDescription)")
        
       /// These headers configure the PMCE on the websocket passed to onUpgrade.
        /// If they passed a pmce config we can parse, return it in to accept the config.
        // could appending a func like reconciled(with:) to supportedCOnfig.headers()
        return requestedConfigs.isEmpty ? req.headers : supportedConfig.headers(xt:true)
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

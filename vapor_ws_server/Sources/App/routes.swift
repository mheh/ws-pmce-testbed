import Vapor
/// To Serve Compressed Websocket Frames ...
///
func routes(_ app: Application) throws {
    
    typealias ClientConfig = PMCE.PMCEConfig.DeflateConfig
    typealias ServerConfig = PMCE.PMCEConfig.DeflateConfig

    /// we use this shouldUpgrade to inject our PMCE headers into the Websocket lifecyle
    app.webSocket("test",
                  maxFrameSize: .default) { req in
        
        let args = app.environment.commandInput.arguments
        if args.first == "pmce" {
            let json = args.last
            req.logger.info("json conf is = \(json)")
        }
        /// Grab the configs from the client if present.
        let requestedConfigs = PMCE.PMCEConfig.configsFrom(headers: req.headers)
        
        app.logger.info("vapor_ws_server: - should ugrade callback requested configs  \(requestedConfigs.debugDescription)")
        
       /// These headers configure the PMCE on the websocket passed to onUpgrade.
        /// If they passed a pmce config we can parse, return it in to accept the config.
        req.logger.info("req.headers = \(req.headers)")
        
        // if they requested something we cant parse, return nothing so they close the pmce request
        return requestedConfigs.first?.headers() ?? [:]
    } onUpgrade: { req, webSoc in
        
        // Our WebSocket's PMCE is configured and it will handle compressing
        // and decompressing behind the scenes for text and binary messages.
        // If no headers were returned above, no compression will be used.
        // wireshark is the beset way to verify usage.
        req.logger.info("client connected.")
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
    
   
}

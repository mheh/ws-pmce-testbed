import Vapor

final class AsyncHostPMCECommand: AnyCommand {
    func run(using context: inout ConsoleKit.CommandContext) throws {
        context.console.info("This is sync.")

    }
    
    
    static let name = "pmce"
    
    struct Signature: CommandSignature {
            
        @Option(name: "client_no_context_takeover",
                short: nil,
                help: "client will reset window for each message",
                completion: CompletionAction())
        var cnct:String?
        
        @Option(name: "server_no_context_takeover",
                short: nil,
                help: "server will reset window for each message",
                completion: CompletionAction())
        var snct:String?
        
        @Option(name: "client_max_window_bits",
                short: nil,
                help: "The maximum size of window as a power of 2 for the client. (8...15) are valid.",
                completion: CompletionAction())
        var cmwb:UInt8?
        
        @Option(name: "server_max_window_bits",
                short: nil,
                help: "The maximum size of window as a power of 2 for the server. (8...15) are valid.",
                completion: CompletionAction())
        var smwb:UInt8?
    }
    
    var help: String {
        "Hosts a websocket with the provided PMCE configuration."
    }
    
    func asyncRun(
        using context: CommandContext,
        signature: Signature
    ) async throws {
        context.console.info("This is async.")
     
    }
    
}

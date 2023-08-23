
import Vapor

struct PMCECommand: Command {
    struct Signature: CommandSignature {
      
        @Argument(name: "json",
                  help: "config document")
        
        var json: String
          init() { }
      }
    
    var help: String {
        "Configures server with the PMCE config"
    }

    func run(using context: CommandContext,
             signature: Signature) throws {
        
        context.console.print("Hello, world!")
    }
}

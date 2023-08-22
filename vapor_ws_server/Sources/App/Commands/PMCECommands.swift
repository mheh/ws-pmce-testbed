//
//  PMCECommands.swift
//  
//
//  Created by Jimmy Hough Jr on 8/2/23.
//

import ConsoleKit
struct HelloCommand: Command {
    struct Signature: CommandSignature {
        @Argument
        var client_no_takeover:Bool
        @Argument
        var server_no_takeover:Bool
        @Argument
        var client_max_window_bits:Int
        @Argument
        var server_max_sindow_bits:Int
        @Argument
        var zlib_mem_level:Int
        @Argument
        var zlib_comp_level:Int

        init() {
            
        }
     }

    var help: String {
        "Says hello"
    }

    func run(using context: CommandContext, signature: Signature) throws {
        context.console.print("Hello, world!")
    }
}
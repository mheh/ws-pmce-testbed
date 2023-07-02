//
//  File.swift
//
//
//  Created by Jimmy Hough Jr on 6/10/23.
//

import Foundation
import Vapor

public protocol AsyncCommand: Command {
    
    func asyncRun(
        using context: CommandContext,
        signature: Signature
    ) async throws
}

public extension AsyncCommand {

    func run(
        using context: CommandContext,
        signature: Signature
    ) throws {
        let promise = context
            .application
            .eventLoopGroup
            .next()
            .makePromise(of: Void.self)
        
        promise.completeWithTask {
            try await asyncRun(
                using: context,
                signature: signature
            )
        }
        try promise.futureResult.wait()
    }
}

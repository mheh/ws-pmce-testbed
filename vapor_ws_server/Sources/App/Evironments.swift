//
//  File.swift
//  
//
//  Created by Jimmy Hough Jr on 8/26/23.
//

import Foundation
import Vapor

extension Environment {
    
    static var staging: Environment {
            .custom(name: "staging")
    }
}


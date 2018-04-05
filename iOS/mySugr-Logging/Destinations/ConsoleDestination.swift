//
//  ConsoleDestination.swift
//  mySugr-Logging
//
//  Created by Florian E. on 04.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation
import os

public class ConsoleDestination: LogDestination {

    public override init() {
        print("[ConsoleDestination] - Setup successfully! 🎉")
    }
    
    override public func write(log: Log) {
        
        var outputString: String = ""
        outputString += "[\(log.level.emoji) \(log.level.rawValue)] — "
        outputString += "\(log.file) -> \(log.function):\(log.line) — \(log.message)"
        
        print(outputString)
    }
}

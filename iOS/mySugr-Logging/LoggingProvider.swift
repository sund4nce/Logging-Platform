//
//  Log.swift
//  mySugr-Logging
//
//  Created by Florian E. on 03.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation

public func log(_ message: String, _ level: LogLevel, _ tags: [String] = [], _ additionalInformation: [String: Any]? = nil, line: Int = #line, function: String = #function, file: String = #file) {
    let log = Log(message: message, level: level, function: function, file: file, line: line, tags: tags, additionalInformation: additionalInformation)
    LoggingProvider.shared.destinations.forEach {
        $0.write(log: log)
    }
}

open class LoggingProvider {
    
    public static let shared = LoggingProvider()
    fileprivate var destinations: [LogDestination]
    
    public init() {
        self.destinations = [ConsoleDestination()]
    }
    
    public func setupDestinations(_ destinations: [LogDestination]) {
        self.destinations = destinations
    }
}

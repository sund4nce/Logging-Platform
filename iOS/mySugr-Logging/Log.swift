//
//  Log.swift
//  mySugr-Logging
//
//  Created by Florian E. on 04.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation

public struct Log: Codable {
    
    public let level: LogLevel
    public let line: Int
    public let function: String
    public let file: String
    public let message: String
    public let dateTime: Int
    public let thread: String
    public let deviceModel: String
    public let tags: [String]
    public let additionalInformation: [String: String]?
    public let iOSVersion: String
    public let deviceUid: String?
    
    public init(message: String, level: LogLevel, function: String, file: String, line: Int, tags: [String] = [], additionalInformation: [String: Any]? = nil) {
        self.message = message
        self.level = level
        self.function = function
        self.file = (file as NSString).lastPathComponent
        self.line = line
        self.dateTime = Int(Date().timeIntervalSince1970 * 1000)
        self.tags = tags
        self.additionalInformation = additionalInformation?.mapValues { value in
            return String(describing: value)
        }
        
        self.thread = {
            if Thread.isMainThread {
                return "main"
            } else {
                let threadName = Thread.current.name
                if let threadName = threadName, !threadName.isEmpty {
                    return threadName
                } else {
                    return String(format: "%p", Thread.current)
                }
            }
        }()
        
        self.deviceModel = {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }()
        
        self.iOSVersion = UIDevice.current.systemVersion
        self.deviceUid = UIDevice.current.identifierForVendor?.uuidString
    }
}

public enum LogLevel: String, Codable {
    case verbose, debug, info, warning, error
    
    public var points: Int {
        switch self {
        case .verbose:
            return 2
        case .debug:
            return 2
        case .info:
            return 2
        case .warning:
            return 6
        case .error:
            return 10
        }
    }
    
    public var emoji: String {
        switch self {
        case .verbose:
            return "📢"
        case .debug:
            return "⚡️"
        case .info:
            return "🦉"
        case .warning:
            return "⚠️"
        case .error:
            return "💥"
        }
    }
}

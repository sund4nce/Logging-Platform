//
//  FileDestination.swift
//  mySugr-Logging
//
//  Created by Florian E. on 04.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation

public class FileDestination: LogDestination {
    
    private let escapeChars = "\u{001b}[38;5;"
    private let resetChars = "\u{001b}[0m"
    
    private let fileManager = FileManager.default
    private let filePath: URL
    private var fileHandle: FileHandle?
    
    public init(filePath: URL? = nil) {
        
        var filePath = filePath
        
        if filePath == nil {
            if let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
                filePath = url
            }
        }
        
        self.filePath = filePath!.appendingPathComponent("log.logger")
        super.init()
        
        if !fileManager.fileExists(atPath: self.filePath.path) {
            fileManager.createFile(atPath: self.filePath.path, contents: Data(), attributes: nil)
        }
        
        do {
            self.fileHandle = try FileHandle(forWritingTo: self.filePath)
        } catch {
            print("[FileDestination] - Error: \(error)")
        }
        
        print("[FileDestination] - Setup successfully! 🎉")
        print("Use \"tail -f \(self.filePath.path)\" for easy displaying.")
    }
    
    override public func write(log: Log) {
        
        var outputString: String = ""
        outputString += "[ \(escapeChars)\(log.level.consoleColor)\(log.level.emoji)  \(log.level.rawValue)\(resetChars) ] — "
        outputString += "\(log.file) - \(log.function) : \(log.line)\n"
        outputString += " — Message: \(log.message)\n"
        outputString += " — Thread: \(log.thread)\n"
        
        if let customAttributes = log.additionalInformation {
            outputString += " — Additional information: \(String(describing: customAttributes))\n"
        }
        
        outputString += "\n"
        
        fileHandle?.seekToEndOfFile()
        fileHandle?.write(outputString.data(using: .utf8)!)
    }
}

fileprivate extension LogLevel {
    var consoleColor: String {
        switch self {
        case .verbose:
            return "159m"
        case .debug:
            return "35m"
        case .info:
            return "33m"
        case .warning:
            return "178m"
        case .error:
            return "197m"
        }
    }
}

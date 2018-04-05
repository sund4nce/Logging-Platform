//
//  LogDestination.swift
//  mySugr-Logging
//
//  Created by Florian E. on 04.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation

public class LogDestination {
    public func write(log: Log) {
        assertionFailure("Only use subclasses.")
    }
}

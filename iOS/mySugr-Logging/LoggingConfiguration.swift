//
//  LoggingConfiguration.swift
//  mySugr-Logging
//
//  Created by Florian E. on 04.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import Foundation

struct LoggingConfiguration: Codable {
    let enabled: String
    let developerName: String
    let destinations: [String]
}

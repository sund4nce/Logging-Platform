//
//  ViewController.swift
//  Sample
//
//  Created by Florian E. on 03.04.18.
//  Copyright © 2018 Florian E. All rights reserved.
//

import UIKit
import mySugr_Logging

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoggingProvider.shared.setupDestinations([
            ConsoleDestination(),
            ElasticsearchDestination(url: URL(string: "https://logging.mort3m.io/api/logs")!),
            FileDestination()
        ])
        
        log("qwertz", .error)
        log("qwertz", .debug)
        log("qwertz", .info)
        log("qwertz", .verbose)
        
        let testData = TestStruct(name: "Get schwifty", url: URL(string: "http://mysugr.com")!)
        
        log("qwertz", .warning, ["LOGI-3250"], ["testObject": testData])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct TestStruct {
    let name: String
    let url: URL
}

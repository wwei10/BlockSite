//
//  ViewController.swift
//  BlockSite
//
//  Created by wwei on 7/1/2020.
//  Copyright © 2020 wwei. All rights reserved.
//

import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    
    let suiteName: String = "group.SC6JAR9UQ9.com.wwei10.BlockSite"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = "BlockSite";
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        let sharedDefaults = UserDefaults(suiteName: self.suiteName)!
        if let startTime = sharedDefaults.string(forKey: "time") {
            NSLog("startTime (\(startTime))")
        }
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.wwei10.BlockSite-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.

            }
        }
    }

}

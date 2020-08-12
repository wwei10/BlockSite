//
//  AppDelegate.swift
//  BlockSite
//
//  Created by wwei on 7/1/2020.
//  Copyright © 2020 wwei. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let suiteName: String = "group.SC6JAR9UQ9.com.wwei10.BlockSite"
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let aem = NSAppleEventManager.shared()
        aem.setEventHandler(self, andSelector: #selector(self.handleGetURLEvent), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))

    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc
    func handleGetURLEvent(event: NSAppleEventDescriptor, reply: NSAppleEventDescriptor) {
        let sharedDefaults = UserDefaults(suiteName: self.suiteName)!
        if let startTime = sharedDefaults.string(forKey: "time") {
            NSLog("startTime (\(startTime))")
        }
        if let path = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue?.removingPercentEncoding {
            NSLog("Opened URL: \(path)")
            let range = NSRange(location: 0, length: path.utf16.count)
            let regex = try! NSRegularExpression(pattern: "add\\?(\\d+)")
            if let match = regex.firstMatch(in: path, options: [], range: range) {
                sharedDefaults.set("\(NSDate().timeIntervalSince1970)", forKey: "time")
                if let durationRange = Range(match.range(at: 1), in: path) {
                    let duration = path[durationRange]
                    sharedDefaults.set("\(duration)", forKey: "duration")
                }
            }
        }
    }
}

//
//  SafariExtensionHandler.swift
//  BlockSite Extension
//
//  Created by wwei on 7/1/2020.
//  Copyright © 2020 wwei. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        let defaults = UserDefaults.standard
        var time: Double = 0
        if let startTime = defaults.string(forKey: "time") {
            NSLog("startTime (\(startTime))")
            time = Double(startTime) ?? 0
        }
        let currentTime = NSDate().timeIntervalSince1970
        let blacklist = ["youtube.com", "facebook.com"]
        if currentTime - time >= 60 * 30 {
            NSLog("early return (\(currentTime - time))")
            return
        }
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
            var shouldBlock = false;
            for item in blacklist {
                if String(describing: properties?.url).contains(item) {
                    shouldBlock = true
                }
            }
            if shouldBlock {
                page.dispatchMessageToScript(withName: "startBlocking")
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
        let defaults = UserDefaults.standard
        defaults.set("\(NSDate().timeIntervalSince1970)", forKey: "time")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}

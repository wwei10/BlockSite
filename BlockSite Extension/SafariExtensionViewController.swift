//
//  SafariExtensionViewController.swift
//  BlockSite Extension
//
//  Created by wwei on 7/1/2020.
//  Copyright © 2020 wwei. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}

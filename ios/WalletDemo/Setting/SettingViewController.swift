//
//  SettingViewController.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/1.
//

import UIKit
import React
import React_RCTAppDelegate

class SettingViewController: UIViewController {
    var reactNativeFactory: RCTReactNativeFactory?
    var reactNativeFactoryDelegate: RCTReactNativeFactoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        reactNativeFactoryDelegate = ReactNativeDelegate()
        reactNativeFactory = RCTReactNativeFactory(delegate: reactNativeFactoryDelegate!)
        view = reactNativeFactory!.rootViewFactory.view(withModuleName: "ReactNativeModule")
    }
}

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
    override func sourceURL(for bridge: RCTBridge) -> URL? {
        self.bundleURL()
    }

    override func bundleURL() -> URL? {
        #if DEBUG
        RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
        Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}

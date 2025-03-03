//
//  ReactNativeBridgeModule.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/3.
//

import Foundation
import React

@objc(ReactNativeBridgeModule)
class ReactNativeBridgeModule: RCTEventEmitter {
    override static func moduleName() -> String! {
        return "ReactNativeBridgeModule"
    }

    override func supportedEvents() -> [String]! {
        return ["onEventFromRN"] // 声明支持的事件名
    }

    @objc func receiveEventFromRN(_ message: Dictionary<String, Any>) {
        print("收到来自 RN 的消息：\(message)")
        
    }
}

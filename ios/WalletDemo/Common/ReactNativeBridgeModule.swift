//
//  ReactNativeBridgeModule.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/3.
//

import Foundation
import React

@objc(ReactNativeBridgeModule)
class ReactNativeBridgeModule: NSObject {
    @objc(handleEventFromRN:message:)
    func handleEventFromRN(_ event: String, message: [String: Any]) {
        NotificationCenter.default.post(
              name: Notification.Name(event),
              object: nil,
              userInfo: message
            )
    }
}

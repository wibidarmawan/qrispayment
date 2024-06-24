//
//  NotificationHandler.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import Foundation

enum NotificationKeyConstants: String {
    case needToRefreshBalance
    case needToRefreshPaymentHistory
}

class NotificationHandler {
    
    static func handleNotificationCenter(keyName: NotificationKeyConstants, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: keyName.rawValue), object: nil, userInfo: userInfo)
    }
    
}

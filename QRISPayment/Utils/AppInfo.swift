//
//  AppInfo.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import CoreFoundation
import UIKit

internal final class AppInfo {
    
    static var topSafeAreaInsets: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        } else if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    static var bottomSafeAreaInsets: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        } else if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    
}

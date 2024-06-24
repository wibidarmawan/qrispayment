//
//  Double+Extensions.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import Foundation

extension Double {
    
    func thousandSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        
        if let formattedNumber = formatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        } else {
            return "\(self)"
        }
    }
    
}

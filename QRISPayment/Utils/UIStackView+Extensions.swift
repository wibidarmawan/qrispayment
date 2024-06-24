//
//  UIStackView+Extensions.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 24/06/24.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
}

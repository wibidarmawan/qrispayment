//
//  UIImageView+Extensions.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

extension UIImageView {
    
    func setImage(image: UIImage?, color: UIColor? = nil) {
        if let color = color {
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        } else {
            self.image = image
        }
    }
}

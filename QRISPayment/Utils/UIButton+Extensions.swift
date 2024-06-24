//
//  UIButton+Extensions.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

extension UIButton {
    
    func setImage(_ image: UIImage?, withTintColor tintColor: UIColor, states: UIControl.State...) {
        guard let image = image else { return }
        
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        
        for state in states {
            self.setImage(tintedImage, for: state)
            self.tintColor = tintColor
        }
    }
    
}

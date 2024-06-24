//
//  UIView+Extensions.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func showToast(message: String, duration: Double = 3.0) {
        // Create the toast label
        let containerView = UIView()
        let toastLabel = UILabel()
        
        containerView.backgroundColor = .primary
        containerView.alpha = 1.0
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        toastLabel.textColor = .black
        toastLabel.textAlignment = .left
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.text = message
        
        self.addSubview(containerView)
        containerView.addSubview(toastLabel)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Spacing.l)
            make.bottom.equalToSuperview().inset(Spacing.xl + AppInfo.bottomSafeAreaInsets)
            make.height.equalTo(35)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.xs)
        }
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            containerView.alpha = 0.0
        }, completion: { (isCompleted) in
            containerView.removeFromSuperview()
        })
    }
    
}

extension UIViewController {
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
}

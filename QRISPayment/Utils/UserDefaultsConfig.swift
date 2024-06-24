//
//  UserDefaultsConfig.swift
//  QRISPayment
//
//  Created by Wibi Darmawan on 23/06/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsConfig {
    
    @UserDefault("isAlreadyAddedInitialBalance", defaultValue: false)
    static var isAlreadyAddedInitialBalance: Bool
    
}

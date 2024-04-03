//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    enum Keys: String {
        case bearerToken
    }
    
    private let keychain = KeychainWrapper.standard
    static let shared = OAuth2TokenStorage()
    
    var token: String? {
        get {
            keychain.string(forKey: Keys.bearerToken.rawValue)
        }
        
        set {
            if let newValue = newValue {
                keychain.set(newValue, forKey: Keys.bearerToken.rawValue)
            } else {
                keychain.removeObject(forKey: Keys.bearerToken.rawValue)
            }
        }
    }
}

extension OAuth2TokenStorage {
    func clean() {
        keychain.removeAllKeys()
    }
}




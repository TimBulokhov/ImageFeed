//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    static var shared = OAuth2TokenStorage()
    
    
    private enum KeysInStorage: String {
        case token
    }
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: KeysInStorage.token.rawValue)
        }
        set {
            if let newValue {
                KeychainWrapper.standard.set(newValue, forKey: KeysInStorage.token.rawValue)
                return
            }
            KeychainWrapper.standard.removeObject(forKey: KeysInStorage.token.rawValue)
        }
    }
}




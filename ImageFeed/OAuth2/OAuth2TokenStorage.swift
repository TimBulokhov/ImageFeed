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
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: "token")
        }
        set {
            assert(newValue != "", "Token is wrong")
            KeychainWrapper.standard.set(newValue!, forKey: "token")
        }
    }
}

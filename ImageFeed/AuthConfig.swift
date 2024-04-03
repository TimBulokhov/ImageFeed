//
//  AuthConfig.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation
import UIKit

enum ApiConstants {
    static let accessKey: String = "-16q6dGRqUg_XxSIzJReF0OnAB8yUbUpFZfaDz1Idu0"
    static let secretKey: String = "8UM5rhvd3kq4cysz9F4qnt3zM2g8HRC0Buyt5hnNbD8"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let unsplashHost = "unsplash.com"
    static let unsplashAuthorizePath = "/oauth/authorize"
    static let unsplashAuthorizeOAuth2String = "/oauth/authorize/native"
    static let unsplashOAuth2TokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashProfileUrlString = "/me"
    static let unsplashUsersUrlString = "/users"
}

struct AuthConfig {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    
    static var standard: AuthConfig {
        return AuthConfig(accessKey: ApiConstants.accessKey,
                          secretKey: ApiConstants.secretKey,
                          redirectURI: ApiConstants.redirectURI,
                          accessScope: ApiConstants.accessScope,
                          authURLString: ApiConstants.unsplashAuthorizeURLString,
                          defaultBaseURL: ApiConstants.defaultBaseURL)
    }
}


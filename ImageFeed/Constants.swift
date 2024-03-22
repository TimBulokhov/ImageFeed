//
//  Constants.swift
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
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
    static let unsplashHost = "unsplash.com"
    static let unsplashAuthorizePath = "/oauth/authorize"
    static let unsplashAuthorizeOAuth2String = "/oauth/authorize/native"
    static let unsplashOAuth2TokenURLString = "https://unsplash.com/oauth/token"
    static let unsplashProfileUrlString = "/me"
    static let unsplashUsersUrlString = "/users"
}



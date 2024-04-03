//
//  AuthConfig.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation
import UIKit

struct AuthConfig {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: String
    let unsplashAuthorizeURLString: String

    static var standard: AuthConfig{
        return AuthConfig(
            accessKey: "-16q6dGRqUg_XxSIzJReF0OnAB8yUbUpFZfaDz1Idu0",
            secretKey: "8UM5rhvd3kq4cysz9F4qnt3zM2g8HRC0Buyt5hnNbD8",
            redirectURI: "urn:ietf:wg:oauth:2.0:oob",
            accessScope: "public+read_user+write_likes",
            defaultBaseURL: ("https://api.unsplash.com"),
            unsplashAuthorizeURLString: "https://unsplash.com/oauth/authorize"
        )
    }
}


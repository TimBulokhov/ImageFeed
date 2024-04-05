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
            accessKey: "mdaKDZFsK-ReLioBh8eulS63G-bPXf6eyRiuUxHmNrc",
            secretKey: "c7WeIOpB5lWe64GsIglB9ORJX1iHLVSZ1XorqmFvjLc",
            redirectURI: "urn:ietf:wg:oauth:2.0:oob",
            accessScope: "public+read_user+write_likes",
            defaultBaseURL: ("https://api.unsplash.com"),
            unsplashAuthorizeURLString: "https://unsplash.com/oauth/authorize"
        )
    }
}


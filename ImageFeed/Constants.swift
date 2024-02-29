//
//  Constants.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation

enum ApiConstants {
    static let accessKey: String = "-16q6dGRqUg_XxSIzJReF0OnAB8yUbUpFZfaDz1Idu0"
    static let secretKey: String = "8UM5rhvd3kq4cysz9F4qnt3zM2g8HRC0Buyt5hnNbD8"
    static let redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope: String = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let unsplashAuthorizeURLString: String = "https://unsplash.com/oauth/authorize"
}



//
//  ProfileServiceModel.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 02.03.2024.
//

import Foundation

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
}

struct ProfileResult: Decodable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}

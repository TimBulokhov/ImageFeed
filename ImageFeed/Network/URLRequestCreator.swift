//
//  URLRequestCreator.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 03.04.2024.
//

import Foundation

final class URLRequestCreator {

    private init() {}

    static let shared = URLRequestCreator()
    private let storage = OAuth2TokenStorage.shared

    // MARK: - HTTP Request
    func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURLString: String = AuthConfig.standard.defaultBaseURL
    ) -> URLRequest? {
        guard
            let url = URL(string: baseURLString),
            let baseURL = URL(string: path, relativeTo: url)
        else { return nil }

        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod

        if let token = storage.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

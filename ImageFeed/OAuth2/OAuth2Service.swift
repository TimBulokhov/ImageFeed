//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation

final class OAuth2Service {
    
    struct OAuthTokenResponseBody: Decodable {
        let accessToken: String
        let tokenType: String
        let scope: String
        let createdAt: Int
    }
    
    enum ParseError: Error {
        case decodeError(Error)
    }
    
    static let shared = OAuth2Service()
    var isLoading = false
    private var task: URLSessionTask?
    private var lastCode: String?
    private let urlSession = URLSession.shared
    private var token: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)

        if lastCode == code { return }
        task?.cancel()
        lastCode = code

        guard let request = makeRequest(with: code) else {
            assertionFailure("Failed to make request")
            return
        }

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in

            guard let self = self else { return }

            switch result {
            case .success(let tokenResponseBody):
                completion(.success(tokenResponseBody.accessToken))
                self.task = nil
            case .failure(let error):
                self.lastCode = nil
                self.task = nil
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }

    private func makeRequest(with code: String) -> URLRequest? {

        guard var urlComponents = URLComponents(string: ApiConstants.accessTokenURL) else {
            assertionFailure("Failed to make URL Components from \(ApiConstants.accessTokenURL)")
            return nil
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ApiConstants.accessKey),
            URLQueryItem(name: "client_secret", value: ApiConstants.secretKey),
            URLQueryItem(name: "redirect_uri", value: ApiConstants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]

        guard let url = urlComponents.url else {
            assertionFailure("Failed to make URL from \(urlComponents)")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        return request
    }
}


 

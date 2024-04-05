//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import Foundation

final class OAuth2Service {

    static let shared = OAuth2Service()
    
    private let urlSession = URLSession.shared
    private let storage = OAuth2TokenStorage.shared
    private let urlRequestFactory = URLRequestCreator.shared
    private var task: URLSessionTask?
    private var lastCode: String?

    private (set) var authToken: String? {
        get {
            return storage.token
        }
        set {
            storage.token = newValue
        }
    }

    var isAuthenticated: Bool {
        storage.token != nil
    }

    let configuration: AuthConfig

    init(configuration: AuthConfig = .standard) {
        self.configuration = configuration
    }

    func fetchAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        let request = authTokenRequest(code: code)
        let task = urlSession.requestTask(for: request) { [weak self] (result: Result <OAuth2TokenResponseBody, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                completion(.success(authToken))
                self.task = nil
            case .failure(let error):
                completion(.failure(error))
                self.lastCode = nil
            }
        }
        self.task = task
        task.resume()
    }

    private func authTokenRequest(code: String) -> URLRequest {
        var components = URLComponents(string: "https://unsplash.com/oauth/token")!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: configuration.accessKey),
            URLQueryItem(name: "client_secret", value: configuration.secretKey),
            URLQueryItem(name: "redirect_uri", value: configuration.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]

        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        return request
    }
}


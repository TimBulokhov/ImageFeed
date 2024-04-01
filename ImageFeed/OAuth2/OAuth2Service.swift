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
    private var task: URLSessionTask?
    private var lastCode: String?
    
    public func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard lastCode != code else {
            return
        }
        
        task?.cancel()
        lastCode = code
        
        let request = makeRequest(code: code)
        let task = urlSession.requestTask(for: request) { [weak self] (result: Result<OAuth2TokenResponseBody, Error>) in
            guard let self = self else {
                return
            }
            
            self.task = nil
            
            switch result {
            case .success(let responseBody):
                let authToken = responseBody.accessToken
                completion(.success(authToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task.resume()
    }
    
    private func makeRequest(code: String) -> URLRequest {
        var urlComponents = URLComponents(string: ApiConstants.unsplashOAuth2TokenURLString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: ApiConstants.accessKey),
            URLQueryItem(name: "client_secret", value: ApiConstants.secretKey),
            URLQueryItem(name: "redirect_uri", value: ApiConstants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let url = urlComponents?.url else {
            fatalError("Unable to create URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
}

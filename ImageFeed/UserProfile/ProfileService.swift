//
//  ProfileAuth.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 01.03.2024.
//

import Foundation

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(result: ProfileResult) {
        self.username = result.username
        self.name = "\(result.firstName) \(result.lastName ?? "")"
        self.loginName = "@\(result.username)"
        self.bio = result.bio
    }
}

final class ProfileService {
    static let shared = ProfileService()
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private(set) var profile: Profile?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        task?.cancel()
        
        let request = makeRequest(token: token)
        
        let task = urlSession.requestTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let profile):
                self.profile = Profile(result: profile)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func makeRequest(token: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.path = ApiConstants.unsplashProfileUrlString
        
        guard let url = urlComponents.url(relativeTo: ApiConstants.defaultBaseURL) else {
            fatalError("Failed to create URL")
            
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
        
    }
}

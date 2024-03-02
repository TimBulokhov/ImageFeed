//
//  ProfileAuth.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 01.03.2024.
//

import Foundation

final class ProfileService {
    
    var profile: ProfileResult?
    private var task: URLSessionTask?
    private var urlSession = URLSession.shared
    static let shared = ProfileService()

    func fetchProfile(_ token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {

        assert(Thread.isMainThread)

        task?.cancel()

        guard var request = URLRequest.makeHTTPRequest(path: "/me", httpMethod: "GET") else {
            assertionFailure("Failed to make HTTP request")
            return
        }

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let profileResult):
                self.profile = profileResult
                completion(.success(profileResult))

            case .failure(let error):
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}


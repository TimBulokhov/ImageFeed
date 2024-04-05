//
//  Extension+URL Request.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 29.02.2024.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case jsonDecodeError
    case urlSessionError
    case invalidRequest
}

extension URLSession {
    func requestTask<Model: Decodable> (
        for request: URLRequest, completion: @escaping (Result<Model, Error>) -> Void) -> URLSessionTask {
            let fillCompletion: (Result<Model, Error>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            let task = dataTask(with: request, completionHandler: { data, response, error in
                if let data = data, let response = response, let statusCode = (response as?  HTTPURLResponse)?.statusCode {
                    if 200 ... 299 ~= statusCode {
                        do {
                            let result = try JSONDecoder().decode(Model.self, from: data)
                            fillCompletion(.success(result))
                        } catch {
                            fillCompletion(.failure(NetworkError.jsonDecodeError))
                        }
                    } else {
                        fillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                } else if let error = error {
                    fillCompletion(.failure(NetworkError.urlRequestError(error)))
                } else {
                    fillCompletion(.failure(NetworkError.urlSessionError))
                }
            })
            task.resume()
            return task
        }
}

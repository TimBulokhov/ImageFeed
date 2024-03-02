//
//  Errors.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 02.03.2024.
//

import Foundation

enum NetworkError: Error {
    case decodingError(Error)
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError(Error)
}

enum ParseError: Error {
    case decodeError(Error)
}

//
//  Errors.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 02.03.2024.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case jsonDecodeError
    case urlSessionError
}

enum ParseError: Error {
    case decodeError(Error)
}

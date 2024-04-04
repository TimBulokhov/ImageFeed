//
//  DateFormatterModel.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 03.04.2024.
//

import Foundation

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

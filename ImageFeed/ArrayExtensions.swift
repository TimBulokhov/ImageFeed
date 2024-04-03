//
//  ArrayExtensions.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 03.04.2024.
//

import Foundation

extension Array {
    func replacingElement(itemAt: Int, newValue: Photo) -> [Photo] {
        var photos = ImagesListService.shared.photos
        photos.replaceSubrange(itemAt...itemAt, with: [newValue])
        return photos
    }
}

//
//  ImagesListPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Timofey Bulokhov on 04.04.2024.
//

import UIKit
@testable import ImageFeed

final class ImagesListPresenterSpy: ImagesListViewPresenterProtocol {

    var view: ImageFeed.ImageListViewControllerProtocol?
    var imagesListService: ImageFeed.ImagesListService
    var photos: [ImageFeed.Photo] = []
    var viewDidLoadCalled = false
    var changeLikeCalled = false
    var tableViewUpdateCheck = false

    init(imagesListService: ImagesListService) {
        self.imagesListService = imagesListService
    }

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func imagesListCellDidTapLike(_ cell: ImageFeed.ImagesListCell, indexPath: IndexPath) {
        changeLike(photoId: "123", isLike: false) { _ in }
    }

    func updateTableViewAnimation() {
        tableViewUpdateCheck = true
    }

    func changeLike(photoId: String, isLike: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        changeLikeCalled = true
    }

}

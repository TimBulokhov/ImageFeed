//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 03.04.2024.
//

import UIKit

final class AlertPresenter {
    weak var delegate: UIViewController?

    func showAlert(
        title: String,
        message: String,
        handler: @escaping () -> Void) {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                handler()
            }
            alert.addAction(okAction)
            delegate?.present(alert, animated: true)
        }
}

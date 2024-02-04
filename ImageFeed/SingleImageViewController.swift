//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 04.02.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    @IBOutlet private var imageView: UIImageView!
    
    @IBOutlet private var backButton: UIButton!
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}

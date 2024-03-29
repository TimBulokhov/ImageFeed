//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 04.02.2024.
//

import UIKit
import Kingfisher

final class SingleImageViewController: UIViewController {
    private lazy var zoomImage: imageZoomer = imageZoomer()
    private let kfManager = KingfisherManager.shared
    private var image: UIImage?
    var imageURL: URL! {
        didSet {
            guard isViewLoaded else { return }
            setImage()
        }
    }
    
    private lazy var shareImageButton: UIButton = {
        let shareImageButton = UIButton()
        shareImageButton.setImage(UIImage(named: "share_button"), for: .normal)
        shareImageButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        shareImageButton.layer.cornerRadius = 25.0
        shareImageButton.backgroundColor = .ypBlack
        return shareImageButton
    }()
    
    @objc private func didTapShareButton(_ sender: UIButton) {
        let share = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addImageConstraints()
        setImage()
    }
    
    private func addSubViews() {
        zoomImage.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(zoomImage, at: 0)
        shareImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(shareImageButton, at: 1)
    }
    
    private func addImageConstraints() {
        NSLayoutConstraint.activate([
            zoomImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            zoomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            zoomImage.topAnchor.constraint(equalTo: view.topAnchor),
            zoomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shareImageButton.heightAnchor.constraint(equalToConstant: 50),
            shareImageButton.widthAnchor.constraint(equalToConstant: 50),
            shareImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            shareImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension SingleImageViewController {
    
    private func setImage() {
        UIBlockingProgressHUD.show()
        
        kfManager.retrieveImage(with: imageURL) { [weak self] result in
            switch result {
            case .success(let value):
                self?.image = value.image
                self?.zoomImage.downloadStartImage(value.image)
            case .failure:
                break
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Download error", message: "Something was wrong, please try again :(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back", style: .default))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action: UIAlertAction) in
            self.setImage()
        }))
        self.present(alert, animated: true)
    }
}




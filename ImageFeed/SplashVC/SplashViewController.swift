//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 25.02.2024.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()


    private let networkService = OAuth2Service.shared
    private let oauthToTokenStorage = OAuth2TokenStorage()
    private let profileService = ProfileAuth.shared
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func showAlert() {
        let alertController = UIAlertController(
            title: "Something was wrong:(",
            message: "Can't log in to the system",
            preferredStyle: .alert
            )

        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            switchToAuthViewController()
        }

        alertController.addAction(action)
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ypBlack
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let token = oauthToTokenStorage.token {
            fetchProfile(with: token)
        } else {

            if !networkService.isLoading {
                switchToAuthViewController()
            }
        }
    }

    private func switchToAuthViewController() {
        guard let authVC = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController
        else { return }
        authVC.delegate = self
        authVC.modalPresentationStyle = .fullScreen
        present(authVC, animated: true)
    }

    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        let tabBar = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBar
    }
}





//MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {

        UIBlockingProgressHUD.show()

        networkService.isLoading = true
        dismiss(animated: true) {
            self.fetchOAuthToken(with: code)
        }
    }

    private func fetchOAuthToken(with code: String) {
        networkService.fetchOAuthToken(code: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                oauthToTokenStorage.token = token
                fetchProfile(with: token)
                UIBlockingProgressHUD.dismiss()
            case.failure(let error):
                UIBlockingProgressHUD.dismiss()
                print(error.localizedDescription)
                showAlert()
            }
        }
    }

    private func fetchProfile(with token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success (let profile):
                ProfileImageService.shared.fetchProfileImageURL(username: profile.username) { _ in }
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                assertionFailure(error.localizedDescription)
            }
        }
    }
}

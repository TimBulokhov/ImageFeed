//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Timofey Bulokhov on 01.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        
        imagesListViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tabImagesListActive"),
            selectedImage: nil
        )
        
        let profileViewController = ProfileViewController()
        
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tabProfile"),
            selectedImage: nil
        )
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}

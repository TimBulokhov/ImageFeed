//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Timofey Bulokhov on 04.04.2024.
//

import UIKit
@testable import ImageFeed

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    
    func profileImageObserver() {
    }
    
    var view: ImageFeed.ProfileViewControllerProtocol?
    private let profileService = ProfileService.shared
    var profileData = Profile(result: ProfileResult(username: "testNickname",
                                                     firstName: "test1stName",
                                                     lastName: "test2ndName",
                                                     bio: "aboutMe"))
    var viewDidLoadCalled = false
    var profileImageCheck = false
    var logoutCheck = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func getProfileImageURL() -> URL? {
        profileImageCheck = true
        return nil
    }

    func getProfileDetails() -> ImageFeed.Profile? {
        let profile = profileData
        return profile
    }

    func cleanAndGoToMainScreen() {
        logoutCheck = true
    }
    
    func prepareAlert() -> (title: String, message: String, actionYes: String, actionNo: String) {
        return ("AlertTitle", "AlertMessage", "Yes", "No")
    }

}

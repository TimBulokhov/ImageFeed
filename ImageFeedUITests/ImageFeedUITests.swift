//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Timofey Bulokhov on 03.04.2024.
//

import XCTest

class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication()
    
    // MARK: - заполнить своими данными
    
    let login = "timofeybrant@mail.ru" //input your login
    let password = "123123123" //input your password
    let username = "Timofey Bulokhov" //input your username
    let nickname = "@timbulokhov" //input your nickname
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["testMode"]
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 3))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 4))
        loginTextField.tap()
        loginTextField.typeText(login)
        sleep(4)
        webView.swipeUp()
        app.toolbars.buttons["Done"].tap()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 4))
        passwordTextField.tap()
        
        passwordTextField.typeText(password)
        sleep(4)
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        sleep(5)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        
        let tableView = app.tables
        let cell = tableView.descendants(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(5)
        
        let cellToLike = tableView.descendants(matching: .cell).element(boundBy: 1)
        let likeButton = cellToLike.buttons["likeButton"]
        XCTAssertTrue(likeButton.waitForExistence(timeout: 10))
        
        likeButton.tap()
        likeButton.tap()
        sleep(5)
        
        cellToLike.tap()
        sleep(5)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButton = app.buttons["navBackButton"]
        navBackButton.tap()
        
    }
    
    
    func testProfile() throws {
        sleep(1)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts[username].exists)
        XCTAssertTrue(app.staticTexts[nickname].exists)
        
        app.buttons["logoutButton"].tap()
        
        sleep(2)
        app.alerts["Exit"].scrollViews.otherElements.buttons["Yes"].tap()
        
        sleep(3)
        XCTAssertTrue(app.buttons["Authenticate"].exists)
    }
}

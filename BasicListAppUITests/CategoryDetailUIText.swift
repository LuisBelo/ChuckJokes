//
//  CategoryDetailUIText.swift
//  CategoryDetailUIText
//
//  Created by Luis Belo on 12/03/21.
//

import XCTest

class CategoryDetailUIText: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testBasicCategoryDetail() throws {
        let categoryTableView = app.tables["categoryListTableView"]
        
        XCTAssertTrue(categoryTableView.exists, "Categories table exists")
        
        let element = categoryTableView.cells.element(boundBy: 1).staticTexts["categoryListCellLabel"].firstMatch
        
        XCTAssert(element.waitForExistence(timeout: 5))
        element.tap()
        
        let imageView = app.images["categoryDetailIcon"]
        let description = app.staticTexts["categoryDetailDescription"]
        let visitButton = app.buttons["categoryDetailLinkButton"]
        
        XCTAssert(imageView.waitForExistence(timeout: 5))
        XCTAssert(description.waitForExistence(timeout: 5))
        XCTAssert(visitButton.waitForExistence(timeout: 5))
    }

}

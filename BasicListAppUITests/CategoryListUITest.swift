//
//  CategoryListUITest.swift
//  CategoryListUITest
//
//  Created by Luis Belo on 08/03/21.
//

import XCTest

class CategoryListUITest: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testBasicHomeViews() throws {
        
        let categoryTableView = app.tables["categoryListTableView"]
        
        XCTAssertTrue(categoryTableView.exists, "Categories table exists")
        
        let element = categoryTableView.cells.element(boundBy: 1).staticTexts["categoryListCellLabel"].firstMatch
        XCTAssert(element.waitForExistence(timeout: 5))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

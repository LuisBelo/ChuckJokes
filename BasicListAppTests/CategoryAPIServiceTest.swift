//
//  CategoryAPIServiceTest.swift
//  CategoryAPIServiceTest
//
//  Created by Luis Belo on 08/03/21.
//

import XCTest
@testable import BasicListApp

class CategoryAPIServiceTest: XCTestCase {

    var sut : CategoryAPIService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CategoryAPIService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testValidCAllToListAllCategories(){
        let exp = expectation(description: "Category count is greater than 0 or error messsage isn't about unavailable server")
        sut.getAllCategories { (result) in
            
            switch result {
            case.Success(let categories):
                XCTAssertTrue(categories.count > 0)
                exp.fulfill()
            case .Failure(let message):
                XCTAssertTrue(!message.isEmpty && message.elementsEqual(NSLocalizedString("generic_call_failed_error", comment: "")))
                exp.fulfill()
            }
            
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testValidCallToSpecificCategory(){
        let exp = expectation(description: "Result is not nil or error messsage isn't about unavailable server")
        sut.getCategoryDetail(category: "animal") { (result) in
            switch result {
            case.Success(let categoryDetail):
                XCTAssertNotNil(categoryDetail)
                exp.fulfill()
            case .Failure(let message):
                XCTAssertTrue(!message.isEmpty && message.elementsEqual(NSLocalizedString("generic_call_failed_error", comment: "")))
                exp.fulfill()
            }
            
        }
        
        wait(for: [exp], timeout: 2)
    }

}

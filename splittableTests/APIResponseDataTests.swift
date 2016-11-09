//
//  APIResponseDataTests.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import XCTest
@testable import splittable

class APIResponseDataTests: XCTestCase {
    
    func testGetData(){
        let TestAPIResponseData: APIResponseData = APIResponseData()
        
        let expect = expectation(description: "Pulls data from the api and runs the callback closure")
        
        TestAPIResponseData.getData { apicallback, imagecallback, success in
            XCTAssertTrue(success)
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testSortArray(){
        let TestAPIResponseData: APIResponseData = APIResponseData()
        
        
        let expect = expectation(description: "Pulls data from the api and runs the callback closure")
        
        let arrayToSort = [["0", "2"], ["0", "1"]]
        let correctSort = [["0", "1"], ["0", "2"]]
        
        TestAPIResponseData.sortArray(responseArray: arrayToSort) { sortedArray, success in
            XCTAssertTrue(success)
            
            XCTAssertEqual(correctSort[0][1], sortedArray[0][1])
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}

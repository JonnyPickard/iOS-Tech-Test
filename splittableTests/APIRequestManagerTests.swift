//
//  APIRequestManagerTests.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import XCTest
@testable import splittable

class APIRequestManagerTests: XCTestCase {
    
    
    func testGetImageFromUrl() {
        let TestAPIRequestManager: APIRequestManager = APIRequestManager()
        
        let expect = expectation(description: "Pulls image from url and runs the callback closure")
        
        let url = "https://res.cloudinary.com/bizzby/image/upload/w_1024,h_576,c_fill/v1450801432/Heroes-NEW2_wnsmmi.jpg"
        TestAPIRequestManager.getImageFromUrl(url: url) { callback, success in
            XCTAssertTrue(success)
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}

//
//  StoreDataTests.swift
//  splittable
//
//  Created by Jonny Pickard on 10/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import XCTest
@testable import splittable

class StoreDataTests: XCTestCase {
    
    func testLoadStoredDataFalse(){
        
        let TestStoreData: StoreData = StoreData()
        
        let expect = expectation(description: "Cannot Load stored data from NSUserDefaults if non existant")
        
        TestStoreData.loadStoredData() { apiDataArray, imageDict, success in
            XCTAssertFalse(success)
            
            
            expect.fulfill()
            self.cleanNSUserDefaults()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testLoadStoredDataTrue(){
        
        //Setup
        let TestStoreData: StoreData = StoreData()
        
        let mockApiDataArray = [["mock"]]
        let mockImageDict = ["mock" : UIImage()]
        
        let defaults = UserDefaults.standard

        let keyedArchApiArray = NSKeyedArchiver.archivedData(withRootObject: mockApiDataArray)
        defaults.set(keyedArchApiArray, forKey: "ApiResponseData")
        
        let keyedArchImageDict = NSKeyedArchiver.archivedData(withRootObject: mockImageDict)
        defaults.set(keyedArchImageDict, forKey: "ImageDict")
        
        let expect = expectation(description: "Loads stored data from NSUserDefaults")
        
        //Execute
        TestStoreData.loadStoredData() { apiDataArray, imageDict, success in
            XCTAssert(success)
            
            expect.fulfill()
            
            //Teardowns
            self.cleanNSUserDefaults()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func cleanNSUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "ApiResponseData")
        UserDefaults.standard.removeObject(forKey: "ImageDict")
    }
}

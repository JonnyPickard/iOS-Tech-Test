//
//  APIResponseData.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class APIResponseData {
    
    func getData(requestManager: APIRequestManager = APIRequestManager(), completion: @escaping (_ responseArray: [[String]], _ imageDict: [String : UIImage]) -> Void) {
        var responseArray = [[String]]()
        
        requestManager.getRequest() { jsonResponse in
            for (_, object) in jsonResponse {
                var array = [String]()
                array.append(object["id"].stringValue)
                array.append(object["sort_order"].stringValue)
                array.append(object["name"].stringValue)
                array.append(object["image_url"].stringValue)
                array.append(object["url"].stringValue)
                responseArray.append(array)
            }
            
            self.sortArray(responseArray: responseArray) { sortedArray in
                self.getImageFromURL(sortedArray: sortedArray){ imageDict in
                    completion(responseArray, imageDict)
                }
            }
        }
    }
    
    func sortArray(responseArray: [[String]], completion: (_ response: [[String]]) -> Void) {
        let sortedArray = responseArray.sorted { ($0[1]) < ($1[1]) }
        completion(sortedArray)
    }
    
    func getImageFromURL(sortedArray: [[String]], requestManager: APIRequestManager = APIRequestManager(), completion: @escaping (_ imageDict: [String : UIImage]) -> Void) {
        let myGroup = DispatchGroup()
        let backgroundQ = DispatchQueue.global(qos: .default)
        let apiArray = sortedArray
        var imageDict = [String : UIImage]()
        
        
        for array in apiArray {
            myGroup.enter()
            
            let imageUrl = array[3]
            let imageID = array[0]
            
            requestManager.getImageFromUrl(url: imageUrl) { imageResponse in
                imageDict[imageID] = imageResponse
                
                myGroup.leave()
            }
            
        }
        
        myGroup.notify(queue: backgroundQ, execute: {
            print("Finished downloading images")
            completion(imageDict)
        })
    }
    
}
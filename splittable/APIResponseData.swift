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
    
    func getData(requestManager: APIRequestManager = APIRequestManager(), completion: @escaping (_ responseArray: [[String]], _ imageDict: [String : UIImage], _ success: Bool) -> Void) {
        
        //Get request
        requestManager.getRequest() { jsonResponse, success in
            //Convert json to multidimensional String array
            self.createArrayFromJSON(jsonResponse) { responseArray, success in
                //Sort array
                self.sortArray(responseArray: responseArray) { sortedArray, success in
                    //Get images using URL from array
                    self.getImagesFromURL(sortedArray: sortedArray){ imageDict, success in
                        //Return the String array and Dict containing the Images
                        completion(responseArray, imageDict, true)
                    }
                }
            }
        }
    }
    
    func createArrayFromJSON(_ jsonResponse :JSON, completion: @escaping (_ array: [[String]], _ success: Bool) -> Void) {
        var responseArray = [[String]]()
        
        print(jsonResponse)
        
        for (_, object) in jsonResponse {

            var array = [String]()
            array.append(object["id"].stringValue)
            array.append(object["sort_order"].stringValue)
            array.append(object["name"].stringValue)
            array.append(object["image_url"].stringValue)
            array.append(object["url"].stringValue)
            responseArray.append(array)
        }
        
        completion(responseArray, true)
    }
    
    func sortArray(responseArray: [[String]], completion: (_ response: [[String]], _ success: Bool) -> Void) {
        let sortedArray = responseArray.sorted { ($0[1]) < ($1[1]) }
        completion(sortedArray, true)
    }
    
    func getImagesFromURL(sortedArray: [[String]], requestManager: APIRequestManager = APIRequestManager(), completion: @escaping (_ imageDict: [String : UIImage], _ success: Bool) -> Void) {
        let myGroup = DispatchGroup()
        let backgroundQ = DispatchQueue.global(qos: .default)
        let apiArray = sortedArray
        var imageDict = [String : UIImage]()
        
        
        for array in apiArray {
            myGroup.enter()
            
            let imageUrl = array[3]
            let imageID = array[0]
            
            requestManager.getImageFromUrl(url: imageUrl) { imageResponse in
                imageDict[imageID] = imageResponse.0
                
                myGroup.leave()
            }
            
        }
        
        myGroup.notify(queue: backgroundQ, execute: {
            print("Finished downloading images")
            completion(imageDict, true)
        })
    }
    
}

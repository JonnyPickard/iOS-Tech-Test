//
//  APIResponseData.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIResponseData {
    var responseArray = [[String]]()
    
    func getData(requestManager: APIRequestManager = APIRequestManager()) {
        requestManager.getRequest() { jsonResponse in
            for (_, object) in jsonResponse {
                var array = [String]()
                array.append(object["id"].stringValue)
                array.append(object["sort_order"].stringValue)
                array.append(object["name"].stringValue)
                array.append(object["image_url"].stringValue)
                array.append(object["url"].stringValue)
                self.responseArray.append(array)
            }
            self.sortArray()
        }
    }
    
    func sortArray() {
        responseArray.sort { ($0[1]) < ($1[1]) }
        getImageFromURL(){ imageDict in
            print(imageDict)
        }
    }
    
    func getImageFromURL(requestManager: APIRequestManager = APIRequestManager(), completion: @escaping (_ imageDict: [String : UIImage]) -> Void) {
        let myGroup = DispatchGroup()
        let backgroundQ = DispatchQueue.global(qos: .default)
        var imageDict = [String : UIImage]()
        
        for array in responseArray {
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

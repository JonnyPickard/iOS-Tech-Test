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
            print("done")
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
    }
    
    
}

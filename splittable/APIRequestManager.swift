//
//  APIRequestManager.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIRequestManager: NSObject {

    
    func getRequest(url: String = "https://sheetsu.com/apis/v1.0/aaf79d4763af", completion: @escaping (JSON) -> Void) {
        print("here")
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}

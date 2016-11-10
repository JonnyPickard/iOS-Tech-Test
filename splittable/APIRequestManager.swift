//
//  APIRequestManager.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class APIRequestManager {

    
    func getRequest(url: String = "https://sheetsu.com/apis/v1.0/aaf79d4763af", completion: @escaping (JSON, _ success: Bool) -> Void) {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageFromUrl(url: String, completion: @escaping (UIImage, _ success: Bool) -> Void) {
        Alamofire.request(url).responseImage { response in
            
            if let image = response.result.value {
                completion(image, true)
            }
            
        }
    }
}

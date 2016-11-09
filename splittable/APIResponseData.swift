//
//  APIResponseData.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import Foundation

class APIResponseData {
    var responseArray = [[String]]()
    
    func getData(requestManager: APIRequestManager = APIRequestManager()) {
        requestManager.getRequest() { completion in
            print(completion)
            print("done")
        }
    }
}

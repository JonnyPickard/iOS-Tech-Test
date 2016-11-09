//
//  MainViewController.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let DataModel = APIResponseData()
    var responseArray = [[String]]()
    var imageDict = [String : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.getData() { apiResponseArray, imageResponseDict in
            self.responseArray = apiResponseArray
            self.imageDict = imageResponseDict
        }
    }

}


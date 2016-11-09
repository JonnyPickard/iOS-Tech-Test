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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.getData()
    }

}


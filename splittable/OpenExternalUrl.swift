//
//  OpenExternalUrl.swift
//  splittable
//
//  Created by Jonny Pickard on 10/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class OpenExternalUrl {
    
    func accessURLFromIdentifier(urlToAccess: String) {
        if let url = NSURL(string: urlToAccess)
        {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}

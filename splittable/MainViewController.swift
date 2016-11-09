//
//  MainViewController.swift
//  splittable
//
//  Created by Jonny Pickard on 09/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let DataModel = APIResponseData()
    var responseArray = [[String]]()
    var imageDict = [String : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.getData() { apiResponseArray, imageResponseDict, succcess in
            self.responseArray = apiResponseArray
            self.imageDict = imageResponseDict
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "splittableCell") {
            let responseID = responseArray[indexPath.row][0]
            
            cell.textLabel?.text = responseArray[indexPath.row][2]
            cell.detailTextLabel?.text = responseArray[indexPath.row][4]
            cell.imageView?.image = imageDict[responseID]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}


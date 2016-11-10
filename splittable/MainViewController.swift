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
        
        let storedData = StoreData()
        print(storedData.checkForStoredData())
        
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
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "splittableCell") as! TableViewCell? {
            let responseID = responseArray[indexPath.row][0]
            
            cell.tableViewTitleLabel?.text = responseArray[indexPath.row][2]
            cell.tableViewImage?.image = imageDict[responseID]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let openExternalURL: OpenExternalUrl = OpenExternalUrl()
        let url = responseArray[indexPath.row][4]
        
        openExternalURL.accessURLFromIdentifier(urlToAccess: url)
    }
}


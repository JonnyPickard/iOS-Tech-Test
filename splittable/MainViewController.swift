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
    @IBOutlet weak var getContentButton: UIButton!
    
    @IBAction func getContentButton(_ sender: Any) {
        if isContentPresent() {
            deleteContent()
        } else {
            getContent()
        }
    }
    
    var responseArray = [[String]]()
    var imageDict = [String : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedData()
    }
    
    func loadSavedData() {
        let dataStore = StoreData()
        
        dataStore.loadStoredData() { apiSavedDataArr, imageSaveDict, success in
            if success {
                self.responseArray = apiSavedDataArr!
                self.imageDict = imageSaveDict!
                
                self.tableView.reloadData()
            }
        }
    }
    
    func getContent() {
        let DataModel = APIResponseData()
        
        DataModel.getData() { apiResponseArray, imageResponseDict, succcess in
            self.responseArray = apiResponseArray
            self.imageDict = imageResponseDict
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.changeGetContentButton()
            }
        }
    }
    
    func deleteContent() {
        responseArray = [[String]]()
        imageDict = [String : UIImage]()
        tableView.reloadData()
    }
    
    func isContentPresent() -> Bool {
        if responseArray.count > 1 {
            return true
        } else {
            return false
        }
    }
    
    func changeGetContentButton(){
        if responseArray.count > 1 {
            getContentButton.setTitle(" Remove Content ", for: .normal)
            getContentButton.setTitleColor(UIColor.white, for: .normal)
            getContentButton.backgroundColor = UIColor.red
        } else {
            getContentButton.setTitle(" Get Content ", for: .normal)
            getContentButton.setTitleColor(UIColor.blue, for: .normal)
            getContentButton.backgroundColor = UIColor.white
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
            
            let url = responseArray[indexPath.row][4]
            if url == "" {
                cell.accessoryType = UITableViewCellAccessoryType.none
                cell.selectionStyle = .none
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
            
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


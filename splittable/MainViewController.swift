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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
    
    func saveData() {
        let dataStore = StoreData()
        
        dataStore.saveData(responseArray, imageDict)
    }
    
    func deleteStoredData() {
        let dataStore = StoreData()
        
        dataStore.deleteStoredData()
    }
    
    func loadSavedData() {
        let dataStore = StoreData()
        
        dataStore.loadStoredData() { apiSavedDataArr, imageSaveDict, success in
            if success {
                self.responseArray = apiSavedDataArr!
                self.imageDict = imageSaveDict!
                
                self.tableView.reloadData()
                self.changeGetContentButton()
            } else {
                self.noContentInTableView(hidden: false)
            }
        }
    }
    
    func getContent() {
        let DataModel = APIResponseData()
        spinner.startAnimating()
        DispatchQueue.global(qos: .default).async {
            
            DataModel.getData() { apiResponseArray, imageResponseDict, succcess in
                self.responseArray = apiResponseArray
                self.imageDict = imageResponseDict
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                    self.changeGetContentButton()
                    self.saveData()
                    self.noContentInTableView(hidden: true)
                }
            }
        }
        
    }
    
    func deleteContent() {
        responseArray = [[String]]()
        imageDict = [String : UIImage]()
        deleteStoredData()
        tableView.reloadData()
        changeGetContentButton()
        noContentInTableView(hidden: false)
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
            getContentButton.setTitleColor(UIColor().lightBlue(), for: .normal)
            getContentButton.backgroundColor = UIColor.white
        }
    }
    
    func noContentInTableView(hidden: Bool) {
        if hidden == false {
            let tvBounds = tableView.bounds
            let frame = CGRect(x: tvBounds.maxX, y: tvBounds.maxY, width: tvBounds.width - 400, height: tvBounds.height)
            
            let noDataLabel: UILabel = UILabel(frame: frame)
            
            noDataLabel.text = "Click the 'Get Content' button below to get content."
            
            noDataLabel.numberOfLines = 0
            noDataLabel.textColor = UIColor.gray
            
            noDataLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
            
            noDataLabel.textAlignment = NSTextAlignment.center
            
            self.tableView.backgroundView = noDataLabel
            self.tableView.separatorColor = UIColor.clear
        } else {
            let clearView = UIView(frame: tableView.bounds)
            self.tableView.backgroundView = clearView
            self.tableView.separatorColor = UIColor.lightGray
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "splittableCell") as! TableViewCell? {
            let responseID = responseArray[indexPath.row][0]
            
            cell.tableViewImage?.image = imageDict[responseID]
            
            let url = responseArray[indexPath.row][4]
            let name = responseArray[indexPath.row][2]

            return checkForURL(url: url, name: name, cell: cell)
        } else {
            return UITableViewCell()
        }
    }
    
    func checkForURL(url: String, name: String, cell: TableViewCell) -> TableViewCell {
        if url == "" {
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.selectionStyle = .none
            cell.tableViewTitleLabel?.text = ""
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.tableViewTitleLabel?.text = name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let openExternalURL: OpenExternalUrl = OpenExternalUrl()
        let url = responseArray[indexPath.row][4]
        
        openExternalURL.accessURLFromIdentifier(urlToAccess: url)
    }
}


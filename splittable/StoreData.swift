//
//  StoreData.swift
//  splittable
//
//  Created by Jonny Pickard on 10/11/2016.
//  Copyright © 2016 Jonny Pickard. All rights reserved.
//

import UIKit

class StoreData {
    
    func loadStoredData(completion: @escaping (_ apiResonseArray: [[String]]?, _ imageDict: [String : UIImage]?, _ success: Bool) -> Void) {
        
        if checkForStoredData() {
            getDictionary() { dictionary in
                self.getArray() { arr in
                    completion(arr, dictionary, true)
                }
            }
        } else {
            completion(nil, nil, false)
        }
    }
    
    func checkForStoredData() -> Bool {
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "ApiResponseData") != nil || (defaults.object(forKey: "ImageDict") != nil) {
            return true
        } else {
            return false
        }
    }
    
    func saveData(_ dataArray: [[String]], _ imageDict: [String : UIImage]) {
        let defaults = UserDefaults.standard
        
        let keyedArchApiArray = NSKeyedArchiver.archivedData(withRootObject: dataArray)
        defaults.set(keyedArchApiArray, forKey: "ApiResponseData")
        
        let keyedArchImageDict = NSKeyedArchiver.archivedData(withRootObject: imageDict)
        defaults.set(keyedArchImageDict, forKey: "ImageDict")
    }
    
    func deleteStoredData(key1: String = "ApiResponseData", key2: String = "ImageDict") {
        UserDefaults.standard.removeObject(forKey: key1)
        UserDefaults.standard.removeObject(forKey: key2)
    }
    
    func getDictionary(key: String = "ImageDict", completion: @escaping ([String : UIImage]?) -> Void) {
        let data = UserDefaults.standard.object(forKey: key)!
        let object = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
    
        completion(object as? [String : UIImage])
    }
    
    func getArray(key: String = "ApiResponseData", completion: @escaping ([[String]]?) -> Void) {        
        let data = UserDefaults.standard.object(forKey: key)!
        let object = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)

        completion(object as? [[String]])
    
    }
    
}

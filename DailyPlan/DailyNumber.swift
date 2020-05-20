//
//  DailyNumber.swift
//  DailyPlan
//
//  Created by zhaoyang on 2020/5/18.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

class DailyNumber: NSObject {
    
    static let cacheFilePath = "dailyData"
    

    class func dailyRandomNumber() -> Int {
        let allValues = self.fetchCache().allValues as NSArray
        var tempRandomNumber = 0
        var exist = false
        repeat {
            tempRandomNumber = Int(arc4random()%365+1)
            if allValues.count != 0 {
                exist = allValues.contains(tempRandomNumber)
            }
        } while exist
        return tempRandomNumber
    }
    
    
    class func insertDailyRandomNumber(date : String?) -> Int {
        guard let inputDate = date else {
            return 0
        }
        let today = self.getDateFormatString()
        
        if inputDate<=today {
            let allKeys = self.fetchCache().allKeys as NSArray
            if allKeys.contains(inputDate) {
                return self.fetchCache()[inputDate] as! Int
            }
            return self.dailyRandomNumber()
        }
        return 0
    }

    class func fetchCache() -> NSDictionary {
        guard let dict = NSDictionary(contentsOfFile: self.cachePath()) else {
            return [:] as NSDictionary
        }
        return dict
    }
    
    
    class func cachePath() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSHomeDirectory()).appending("/"+cacheFilePath)
    }
    
    
    class func getDateFormatString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: Date())
    }
}

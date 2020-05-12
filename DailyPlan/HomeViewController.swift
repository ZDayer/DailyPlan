//
//  HomeViewController.swift
//  DailyPlan
//
//  Created by zhaoyang on 2020/5/11.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    let cacheFilePath = "dailyData"
    var randomNumber = 0
    var randomNumberExist = false
    var clickView : UIView!
    var lbl : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.checkTodayCache()
        self.initSubviews()
    }
    
    func initSubviews() {
        
        self.clickView = UIView()
        self.view.addSubview(self.clickView)
        self.clickView.snp.makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.center.equalToSuperview()
        }
        self.clickView.backgroundColor = self.randomNumberExist ? UIColor(named: "disColor") : UIColor(named: "bgColor")
        self.clickView.layer.cornerRadius = 125
        self.clickView.layer.masksToBounds = true
        self.clickView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateDailyRandomNumber)))

        self.lbl = UILabel()
        self.clickView.addSubview(self.lbl)
        self.lbl.text = self.randomNumberExist ? String(self.randomNumber) : "选择今日数字"
        self.lbl.font = UIFont.boldSystemFont(ofSize: self.randomNumberExist ? 80 : 25)
        self.lbl.textColor = UIColor.white
        self.lbl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func dailyRandomNumber(allValues : NSArray) -> Int {

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
    
    func fetchCache() -> NSDictionary {
        guard let dict = NSDictionary(contentsOfFile: self.cachePath()) else {
            return [:] as NSDictionary
        }
        return dict
    }
    
    
    func cachePath() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSHomeDirectory()).appending("/"+cacheFilePath)
    }
    
    func getDateFormatString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: Date())
    }
    
    func checkTodayCache() {
        let dic = self.fetchCache()
        let today = self.getDateFormatString()
        let allkeys:NSArray = dic.allKeys as NSArray
        let exist = allkeys.contains(today)
        if exist {
            self.randomNumber = dic[today] as! Int
        }
        self.randomNumberExist = exist
    }
    
    @objc func updateDailyRandomNumber() {
        if self.randomNumberExist {
            let detailTVC = DetailTableViewController()
            self.navigationController?.pushViewController(detailTVC, animated: true)
            return
        }
        let dic = self.fetchCache()
        let today = self.getDateFormatString()
        self.randomNumber = self.dailyRandomNumber(allValues: dic.allValues as NSArray)
        let tempDic = NSMutableDictionary(dictionary: dic)
        tempDic.setValue(self.randomNumber, forKey: today)
        tempDic.write(toFile: self.cachePath(), atomically: true)
        self.randomNumberExist = true
        self.updateView()
    }
    
    
    func updateView() {
        self.lbl.text = String(self.randomNumber)
        self.lbl.font = UIFont.boldSystemFont(ofSize: 80)
        self.clickView.backgroundColor = UIColor(named: "disColor")
    }
    
}

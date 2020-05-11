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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initSubviews()
    }
    
    func initSubviews() {
        
        let clickView = UIView()
        self.view.addSubview(clickView)
        clickView.snp.makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.center.equalToSuperview()
        }
        clickView.backgroundColor = UIColor.blue
        clickView.layer.cornerRadius = 125
        clickView.layer.masksToBounds = true
        clickView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dailyRandomNumber)))

        let lbl = UILabel()
        clickView.addSubview(lbl)
        lbl.text = "选择今日数字"
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textColor = UIColor.white
        lbl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func dailyRandomNumber() {
        let randomNumber = arc4random()%365+1
        print(randomNumber)
    }
    
    func fetchCache() -> NSDictionary {
        guard let dict = NSDictionary(contentsOfFile: self.cachePath()) else {
            return [:]
        }
        return dict
    }
    
    
    func cachePath() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSHomeDirectory()).appending("/"+cacheFilePath)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let path = Bundle.main.path(forResource: "dailyData", ofType: nil) else {
//            print("empty path")
//            return
//        }
//        let dic = NSDictionary(contentsOfFile: path)
//        print(dic as Any)
//        guard let dict = dic else {
//            return
//        }
//        dict.write(toFile: self.cachePath(), atomically: true)
//
        
        print(self.fetchCache())
        print(self.getDateFormatString())
    }

    func getDateFormatString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: Date())
    }
    
    func checkTodayCache() {
//        let dic = self.fetchCache()
//        let today = self.getDateFormatString()
//        let exist = dic.allKeys.contains { $0 == today }
//        print(exist)
//
//        let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
//        let hasBigPurchase = expenses.contains { $0 > 100 }
    }
    

}

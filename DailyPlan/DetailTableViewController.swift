//
//  DetailTableViewController.swift
//  DailyPlan
//
//  Created by zhaoyang on 2020/5/12.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var cacheData : NSDictionary?
    let cacheFilePath = "dailyData"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(DetailTableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        
        guard let tempCacheData = NSDictionary(contentsOfFile: self.cachePath()) else {
            return
        }
        cacheData = tempCacheData
        
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cacheData?.allKeys.count)!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DetailTableViewCell
        let key = cacheData?.allKeys[indexPath.row]
        let value = cacheData?[key!]
//        print("value = \(value as Any)")
        
//        print("value1 = \(value as? String ?? "value-----")")
//
//        print("value2 = \(String(describing: value as? String))")

        guard let str = value as? String else {
            print("empty str")
            return DetailTableViewCell()
        }
        print("value = \(str)")
        
        cell.titleStr = value as? String
        cell.subTitleStr = key as? String
        return cell
    }
    
    func cachePath() -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSHomeDirectory()).appending("/"+cacheFilePath)
    }
}


class DetailTableViewCell: UITableViewCell {
    var titleLbl : UILabel!
    var subTitleLbl : UILabel!
    var titleStr : String? {
        willSet {
//            print("newValue = \(newValue as Any)")
            titleLbl.text = newValue
        }
    }
    var subTitleStr : String? {
        willSet {
//            print("newValues = \(newValue as Any)")
            subTitleLbl.text = newValue
        }
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubviews()
    }
    
    func initSubviews() {
        titleLbl = UILabel()
        self.contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.bottom.equalToSuperview()
        }
        titleLbl.font = UIFont.boldSystemFont(ofSize: 20)
//        titleLbl.text = titleStr
        
        subTitleLbl = UILabel()
        self.contentView.addSubview(subTitleLbl)
        subTitleLbl.snp.makeConstraints { (make) in
            make.trailing.equalTo(-15)
            make.top.bottom.equalToSuperview()
        }
        subTitleLbl.font = UIFont.systemFont(ofSize: 18)
//        subTitleLbl.text = subTitleStr
        subTitleLbl.textColor = UIColor.lightGray
    }
    
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

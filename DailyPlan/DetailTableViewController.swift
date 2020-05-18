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
    var keys : [Any]!
    var totalNumber : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.customNaviBar()
        self.tableView.register(DetailTableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        
        
        guard let tempCacheData = NSDictionary(contentsOfFile: DailyNumber.cachePath()) else {
            return
        }
        self.updateData(tempCacheData: tempCacheData)
    }
    
    func updateData(tempCacheData : NSDictionary)  {
        cacheData = tempCacheData
        keys = cacheData?.allKeys
        keys?.sort(by: { (key1, key2) -> Bool in
            let key1Str = key1 as! String
            let key2Str = key2 as! String
            return key1Str>key2Str
        })
        
        let values = (cacheData?.allValues)!
        var total = 0
        for item in values {
            let num = (item as! NSNumber).intValue
            total += num
        }
        totalNumber = String(total)
    }
    
    func customNaviBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backMethod))
        self.navigationItem.title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(insertDailyData))
    }

    @objc func backMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func insertDailyData() {
        let alert = UIAlertController(title: "", message: "请输入日期", preferredStyle: .alert)
        alert.addTextField { textInput in
            textInput.placeholder = "请输入日期"
            textInput.textColor = UIColor.black
            textInput.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { action in
            self.reloadDailyNumber(inputDate: alert.textFields?.last?.text)
        }))
            
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func reloadDailyNumber(inputDate : String?) {
        guard let inputDateStr = inputDate else {
            return
        }
        let randomNumber = DailyNumber.insertDailyRandomNumber(date: inputDateStr)
        if randomNumber == 0 {
            let alert = UIAlertController(title: "", message: "请输入正确的日期", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        cacheData?.setValue(randomNumber, forKey: inputDateStr)
        self.updateData(tempCacheData: cacheData!)
        cacheData!.write(toFile: DailyNumber.cachePath(), atomically: true)
        self.tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.customHeaderView()
    }
    
    func customHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "headColor")
        let totalNumberLbl = UILabel()
        view.addSubview(totalNumberLbl)
        totalNumberLbl.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(15)
        }
        totalNumberLbl.text = totalNumber
        
        let totalDayLbl = UILabel()
        view.addSubview(totalDayLbl)
        totalDayLbl.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(-15)
        }
        totalDayLbl.text = String(keys.count)

        return view
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cacheData?.allKeys.count)!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DetailTableViewCell
        let key = keys[indexPath.row]
        let value = cacheData?[key]
        cell.titleStr = NumberFormatter.init().string(from: (value as? NSNumber)!)
        cell.subTitleStr = key as? String
        return cell
    }
    
}


class DetailTableViewCell: UITableViewCell {
    var titleLbl : UILabel!
    var subTitleLbl : UILabel!
    var titleStr : String? {
        willSet {
            titleLbl.text = newValue
        }
    }
    var subTitleStr : String? {
        willSet {
            subTitleLbl.text = newValue
        }
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        
        subTitleLbl = UILabel()
        self.contentView.addSubview(subTitleLbl)
        subTitleLbl.snp.makeConstraints { (make) in
            make.trailing.equalTo(-15)
            make.top.bottom.equalToSuperview()
        }
        subTitleLbl.font = UIFont.systemFont(ofSize: 18)
        subTitleLbl.textColor = UIColor.lightGray
    }
    
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

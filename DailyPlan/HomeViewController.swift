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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initSubviews()
    }
    
    func initSubviews() {
        
        let clickView = UIView()
        clickView.backgroundColor = .blue
        clickView.layer.cornerRadius = 125
        self.view.addSubview(clickView)
        clickView.snp.makeConstraints { (make) in
            make.width.height.equalTo(250)
            make.center.equalToSuperview()
        }
        
        let lbl = UILabel()
        clickView.addSubview(lbl)
        lbl.text = "选择今日数字"
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textColor = .white
        lbl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }

}

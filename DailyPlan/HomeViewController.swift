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
        let subView = UIView()
        subView.backgroundColor = UIColor.red
        self.view.addSubview(subView)
        subView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.width.height.equalTo(100)
            ConstraintMaker.center.equalToSuperview()
        }
    }

}

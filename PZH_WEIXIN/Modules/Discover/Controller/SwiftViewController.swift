//
//  SwiftViewController.swift
//  PZH_WEIXIN
//
//  Created by PT iOS Mac on 2020/4/15.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {
    
    var helloLabel:UILabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
        helloLabel.center = self.view.center
        helloLabel.text = "测试Swift"
        self.view.addSubview(helloLabel)
        // Do any additional setup after loading the view.
    }

}

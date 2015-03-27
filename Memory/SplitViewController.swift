//
//  SplitViewController.swift
//  Memory
//
//  Created by xlx on 15/3/28.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController,UISplitViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        // Do any additional setup after loading the view.
    }

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return true
    }
    

}

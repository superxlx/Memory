//
//  MemoViewController.swift
//  Memory
//
//  Created by xlx on 15/4/7.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)


    }
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

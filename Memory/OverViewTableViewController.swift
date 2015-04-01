//
//  OverViewTableViewController.swift
//  Memory
//
//  Created by xlx on 15/3/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit

class OverViewTableViewController: UIViewController {

    @IBOutlet weak var addback: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.selectedImageTintColor=UIColor.purpleColor()
    //    self.navigationController?.navigationBar.backgroundColor=UIColor(red: 249/255, green: 225/255, blue: 222/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.greenColor()]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(sender: AnyObject) {
        if self.addback.hidden {
            self.addback.hidden=false
        }else{
            self.addback.hidden=true
        }
    }

}

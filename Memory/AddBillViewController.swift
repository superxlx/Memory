//
//  AddBillViewController.swift
//  Memory
//
//  Created by xlx on 15/3/30.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class AddBillViewController: UIViewController,UITableViewDelegate{

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lockstate: UIButton!

    @IBOutlet weak var tableview: UITableView!
    var islock=false
    var delegate:UITableViewDelegate!
    var billCount=[true]
    override func viewDidLoad() {
        super.viewDidLoad()
        var date=NSDate()
        var dateFormat=NSDateFormatter()
        dateFormat.dateFormat="YYYY年MM月dd日HH时mm分"
        var dat=dateFormat.stringFromDate(date)
        self.time.text=dat
     
        self.tableview.separatorStyle=UITableViewCellSeparatorStyle.None

        
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleKeyboardDidShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleKeyboardDidHidden"), name:UIKeyboardWillHideNotification, object: nil)
        super.viewWillAppear(true)
        
    }
    func handleKeyboardDidShow(paramNotification:NSNotification){
        var userinfo:NSDictionary=(NSDictionary)(dictionary: paramNotification.userInfo!)
        var v:NSValue=userinfo.objectForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        var keyboardRect=v.CGRectValue()
        self.tableview.contentInset=UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0)
    }
    func handleKeyboardDidHidden(){
        self.tableview.contentInset=UIEdgeInsetsZero
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(sender: AnyObject) {
       
    }
    @IBAction func lock(sender: AnyObject) {
        if islock {
            self.lockstate.setImage(UIImage(named: "unlocked"), forState: UIControlState.Normal)
            self.islock=false
        }else{
            self.lockstate.setImage(UIImage(named: "locked"), forState: UIControlState.Normal)
            self.islock=true
        }
    }

    @IBAction func cenael(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Potentially incomplete method implementation.
            // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete method implementation.
            // Return the number of rows in the section.
        return self.billCount.count+1
    }
    

    
    @IBAction func subBillcount(sender: AnyObject) {
        self.billCount.append(false)
        self.tableview.reloadData()
    }
    @IBAction func addBillcount(sender: AnyObject) {
        self.billCount.append(true)
        self.tableview.reloadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    
        if indexPath.row == self.billCount.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! UITableViewCell
            return cell
        }else if indexPath.row == self.billCount.count-1 {
            if self.billCount[indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
                var label=cell.viewWithTag(1)
                label?.becomeFirstResponder()
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! UITableViewCell
                var label=cell.viewWithTag(1)
                label?.becomeFirstResponder()
                return cell
            }
            
            
            
        }else{
            if self.billCount[indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! UITableViewCell
                return cell
            }

        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
    @IBAction func hiddenKeyBoard(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    }
}

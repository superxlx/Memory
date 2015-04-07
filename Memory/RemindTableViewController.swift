//
//  RemindTableViewController.swift
//  Memory
//
//  Created by xlx on 15/3/30.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class RemindTableViewController: UITableViewController,RemindDelegate,isRemindDelegate{
    @IBOutlet var tableview: UITableView!
    var context:NSManagedObjectContext!
    var contextdetial=[AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.greenColor()]
        
        
        var entity=NSFetchRequest(entityName: "Remind")
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        self.contextdetial=context!.executeFetchRequest(entity, error: nil)!
        
        var appdelegate=UIApplication.sharedApplication().delegate as AppDelegate
        appdelegate.isRemind=self
  
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func remindreload() {
        var entity=NSFetchRequest(entityName: "Remind")
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        self.contextdetial=context!.executeFetchRequest(entity, error: nil)!
        self.tableview.reloadData()

        self.tableview.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return contextdetial.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let text=cell.viewWithTag(1) as UILabel
        let date=cell.viewWithTag(2) as UILabel
        
        if let a=contextdetial[indexPath.row].valueForKey("content") as? String{
            text.text=a
        }else{
            text.text="提醒"
        }
        
        var time=contextdetial[indexPath.row].valueForKey("date") as? NSDate
        var dateFormat=NSDateFormatter()
        dateFormat.dateFormat="MM月dd日HH时mm分"
        var dat=dateFormat.stringFromDate(time!)
        date.text=dat

        
        var datenow=NSDate()
        var datepicker=contextdetial[indexPath.row].valueForKey("date") as NSDate
        if datenow.earlierDate(datenow)==datepicker {
            cell.selectionStyle=UITableViewCellSelectionStyle.None
            cell.backgroundColor=UIColor.grayColor()
            println("\(indexPath.row)\tisremind")
        }else{
            println("\(indexPath.row)\tremind")
        }

        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        var datenow=NSDate()
        var date=contextdetial[indexPath.row].valueForKey("date") as NSDate
        if datenow.earlierDate(date)==date {
            //从数据中删除
            self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
            context.deleteObject(self.contextdetial[indexPath.row] as NSManagedObject)
            context.save(nil)
            var entity=NSFetchRequest(entityName: "Remind")
            self.contextdetial=context.executeFetchRequest(entity, error: nil)!

        }else{
        
        //从数据中删除
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        context.deleteObject(self.contextdetial[indexPath.row] as NSManagedObject)
        context.save(nil)
        var entity=NSFetchRequest(entityName: "Remind")
        self.contextdetial=context.executeFetchRequest(entity, error: nil)!
        //取消推送
        let local=UIApplication.sharedApplication()
        let cancelnotification=local.scheduledLocalNotifications[indexPath.row] as UILocalNotification
        local.cancelLocalNotification(cancelnotification)
        }
        
        
        tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as UINavigationController
        let controller = navigationController.topViewController as AddRemindViewController
        controller.delegate=self
    }
    func isremindreload(){
        println("remind have reload")
        self.tableview.reloadData()
    }
}

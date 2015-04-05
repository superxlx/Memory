//
//  RemindTableViewController.swift
//  Memory
//
//  Created by xlx on 15/3/30.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class RemindTableViewController: UITableViewController,RemindDelegate{
    @IBOutlet var tableview: UITableView!
    var context:NSManagedObjectContext!
    var contextdetial=[AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.greenColor()]
        
        
        
        
        var entity=NSFetchRequest(entityName: "Remind")
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        self.contextdetial=context!.executeFetchRequest(entity, error: nil)!

        
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
        
        text.text=contextdetial[indexPath.row].valueForKey("content") as? String
        
        var time=contextdetial[indexPath.row].valueForKey("date") as? NSDate
        var dateFormat=NSDateFormatter()
        dateFormat.dateFormat="MM月dd日HH时mm分"
        var dat=dateFormat.stringFromDate(time!)
        date.text=dat


        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        
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
        
        
        tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as UINavigationController
        let controller = navigationController.topViewController as AddRemindViewController
        controller.delegate=self
    }
    

}

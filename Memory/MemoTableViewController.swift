//
//  MemoTableViewController.swift
//  Memory
//
//  Created by xlx on 15/3/30.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class MemoTableViewController: UITableViewController,MemosureDelegate{

    @IBOutlet var tableview: UITableView!
    var context:NSManagedObjectContext!
    var contextdetial=[AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.greenColor()]
        
        
        
        var entity=NSFetchRequest(entityName: "Memo")
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        self.contextdetial=context!.executeFetchRequest(entity, error: nil)!
        
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    func memoreload(){
        var entity=NSFetchRequest(entityName: "Memo")
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        self.contextdetial=context!.executeFetchRequest(entity, error: nil)!
        self.tableview.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let title=cell.viewWithTag(1) as UILabel
        var titlecontent:String=contextdetial[indexPath.row].valueForKey("title") as  String
        if titlecontent=="" {
            titlecontent="未命名"
        }
        title.text=titlecontent
        let islock:Bool=contextdetial[indexPath.row].valueForKey("lock") as Bool
        let lockimage=cell.viewWithTag(2) as UIImageView
        if islock {
            lockimage.image=UIImage(named: "locked")
        }
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="view" {
            let controller=segue.destinationViewController as MemoViewController
            controller.hidesBottomBarWhenPushed=true
        }else if segue.identifier=="add" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as AddMemoViewController
            controller.Memodelegate = self
        }
    }

    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        context.deleteObject(self.contextdetial[indexPath.row] as NSManagedObject)
        context.save(nil)
        var entity=NSFetchRequest(entityName: "Memo")
        self.contextdetial=context.executeFetchRequest(entity, error: nil)!
        
        tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}

//
//  AddRemindViewController.swift
//  Memory
//
//  Created by xlx on 15/4/2.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class AddRemindViewController: UIViewController {

    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var picker: UIDatePicker!
    var delegate:RemindDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    func sortdate(a:AnyObject,b:AnyObject)->Bool{
        let date1:NSDate=a.valueForKey("date") as! NSDate
        let date2:NSDate=b.valueForKey("date") as! NSDate
        return date1.earlierDate(date2)==date1
        
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        var context=(UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Remind", inManagedObjectContext: context!)
        row.setValue(self.text.text, forKey: "content")
        row.setValue(self.picker.date, forKey: "date")
        context?.save(nil)
        
        var notification=UILocalNotification()
        notification.fireDate=self.picker.date
        notification.timeZone=NSTimeZone.defaultTimeZone()
        notification.soundName=UILocalNotificationDefaultSoundName
        notification.alertAction="打开"
        let a=self.text.text
        if a != ""{
            notification.alertBody=self.text.text
        }else{
            notification.alertBody="Memory 提醒"
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        self.dismissViewControllerAnimated(true, completion: {() in
                self.delegate.remindreload()
            })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hiddenKeyBoard(sender: AnyObject) {
        UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
    }


}

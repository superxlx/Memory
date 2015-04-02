//
//  AddMemoViewController.swift
//  Memory
//
//  Created by xlx on 15/3/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class AddMemoViewController: UIViewController,UITextViewDelegate{

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lockstate: UIButton!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var Memotitle: UITextField!
    var islock=false
    var Memodelegate:MemosureDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.text.becomeFirstResponder()
        self.text.delegate=self
        var date=NSDate()
        var dateFormat=NSDateFormatter()
        dateFormat.dateFormat="YYYY年MM月dd日HH时mm分"
        var dat=dateFormat.stringFromDate(date)
        self.time.text=dat
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func initmemo(title:String,text:String,lock:Bool){
    
    }
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleKeyboardDidShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleKeyboardDidHidden"), name:UIKeyboardWillHideNotification, object: nil)
        super.viewWillAppear(true)
        
    }
    func handleKeyboardDidShow(paramNotification:NSNotification){
        var userinfo:NSDictionary=(NSDictionary)(dictionary: paramNotification.userInfo!)
        var v:NSValue=userinfo.objectForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
        var keyboardRect=v.CGRectValue()
        self.text.contentInset=UIEdgeInsetsMake(0, 0, keyboardRect.size.height+100, 0)
    }
    func handleKeyboardDidHidden(){
        self.text.contentInset=UIEdgeInsetsZero
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
        var context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Memo", inManagedObjectContext: context!)
        row.setValue(self.Memotitle.text, forKey: "title")
        row.setValue(NSDate(), forKey: "date")
        row.setValue(self.text.text, forKey: "content")
        row.setValue(self.islock, forKey: "lock")
        context?.save(nil)
        
        self.dismissViewControllerAnimated(true, completion: {() in
            self.Memodelegate.memoreload()
        })
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
    }
    

}

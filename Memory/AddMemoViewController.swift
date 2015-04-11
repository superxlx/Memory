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
    @IBOutlet weak var leftbarButton: UIBarButtonItem!
    @IBOutlet weak var leftButtonBottom: UIView!
    @IBOutlet weak var layview: UIView!
    @IBOutlet weak var insert: UIImageView!
    @IBOutlet weak var save: UIImageView!
    var islock=false
    var Memodelegate:MemosureDelegate!
    var viewwidth:CGFloat!
    var isfirst=true
    var effect=true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewwidth=self.view.bounds.width
        
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
        var v:NSValue=userinfo.objectForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        var keyboardRect=v.CGRectValue()
        self.text.contentInset=UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0)
    }
    func handleKeyboardDidHidden(){
        self.text.contentInset=UIEdgeInsetsZero
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func save(sender: AnyObject) {
//        var context=(UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
//        var row:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Memo", inManagedObjectContext: context!)
//        row.setValue(self.Memotitle.text, forKey: "title")
//        row.setValue(NSDate(), forKey: "date")
//        row.setValue(self.text.text, forKey: "content")
//        row.setValue(self.islock, forKey: "lock")
//        context?.save(nil)
//        
//        self.dismissViewControllerAnimated(true, completion: {() in
//            self.Memodelegate.memoreload()
//        })
        var button1=self.leftButtonBottom.viewWithTag(1)! as! UIButton
        var button2=self.leftButtonBottom.viewWithTag(2)! as! UIView
        if self.leftButtonBottom.hidden{
            if effect {
            effect=false
            layview.hidden=false
            insert.hidden=false
            layview.alpha=0.7
            button2.center.y=70
            insert.alpha=1
            insertBlurView(layview, UIBlurEffectStyle.Light)
            self.leftbarButton.image=UIImage(named: "Arrow Right in Circle")
            self.leftButtonBottom.hidden=false
            
            button1.hidden=false
            if self.isfirst{
                self.isfirst=false
                gradualchange_move(10, "x",-70, button1)
            }else{
            //    button1.center.x-=70
                gradualchange_move(10, "x",-70, button1)
                button1.transform=CGAffineTransformTranslate(view.transform, 0,0)
            }
            gradualchange_move(10, "x", self.viewwidth, self.insert)
                
            var minseconds=0.8*Double(NSEC_PER_SEC)
            var dtime=dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
            dispatch_after(dtime,dispatch_get_main_queue(),{
                
                button2.hidden=false
                self.save.hidden=false
                gradualchange_rotation(20, 270, button2)
                self.save.alpha=1
                
                gradualchange_move(10, "x", self.viewwidth, self.save)
                var minseconds=1*Double(NSEC_PER_SEC)
                var dtime=dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
                dispatch_after(dtime,dispatch_get_main_queue(),{
                    
                    self.effect=true
                    
                })
                
            })
            }
        }else {
            if effect{
            self.effect=false
            self.leftbarButton.image=UIImage(named: "Arrow Left in Circle")
            gradualchange_alpha(1, 0, save)
            gradualchange_rotation(20, -360, button2)
            var minseconds=0.8*Double(NSEC_PER_SEC)
            var dtime=dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
            dispatch_after(dtime,dispatch_get_main_queue(),{
                
                gradualchange_alpha(1, 0, self.insert)
                gradualchange_moveTo(10, "x",-70, button1)
                button2.center.y -= 70
                gradualchange_moveTo(10, "x",-70, button2)
                var minseconds=0.8*Double(NSEC_PER_SEC)
                var dtime=dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
                dispatch_after(dtime,dispatch_get_main_queue(),{
                    gradualchange_alpha(0.5, 0, self.layview)
                    button1.hidden=true
                    button2.hidden=true
                    var minseconds=0.5*Double(NSEC_PER_SEC)
                    var dtime=dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
                    dispatch_after(dtime,dispatch_get_main_queue(),{
                        self.leftButtonBottom.hidden=true
                        self.effect=true
                    })
                })
            })
            }
        }
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

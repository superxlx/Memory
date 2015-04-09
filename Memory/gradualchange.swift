import UIKit
    func gradualchange_alpha(time:NSTimeInterval,alp:CFloat,view:UIView){
        UIView.animateWithDuration(time, delay:0,options:UIViewAnimationOptions.CurveEaseInOut,animations:{()->Void in
            view.alpha=(CGFloat)(alp)
            },completion:nil)
    }
   func gradualchange_size(time:NSTimeInterval,width:CFloat,height:CGFloat,view:UIView){
    let jnw2=JNWSpringAnimation(keyPath: "transform.scale")
    jnw2.damping=10
    jnw2.stiffness=10
    jnw2.mass=1
    jnw2.fromValue=1
    jnw2.toValue=0
    view.layer.addAnimation(jnw2, forKey: jnw2.keyPath)
    view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0,0)
   }
   func gradualchange_rotation(speed:CGFloat,angle:Double,view:UIView){
    let rotation=JNWSpringAnimation(keyPath: "transform.rotation")
    rotation.damping=speed
    rotation.stiffness=0
    rotation.mass=2
    rotation.fromValue=0
    rotation.toValue=(angle/180)*M_PI
    view.layer.addAnimation(rotation, forKey: rotation.keyPath)
    view.transform=CGAffineTransformMakeRotation((CGFloat)(M_PI/2*3))
    
   }
func gradualchange_move(speed:CGFloat,direction:String,distance:CGFloat,view:UIView){
    let mapTranslate=JNWSpringAnimation(keyPath: "transform.translation.\(direction)")
    mapTranslate.damping=speed
    mapTranslate.stiffness=0
    mapTranslate.mass=1
    mapTranslate.fromValue = distance
    mapTranslate.toValue=0
    view.layer.addAnimation(mapTranslate, forKey: mapTranslate.keyPath)
    view.transform=CGAffineTransformTranslate(view.transform, 0,0)

    
}
func gradualchange_moveTo(speed:CGFloat,direction:String,distance:CGFloat,view:UIView){
    let mapTranslate=JNWSpringAnimation(keyPath: "transform.translation.\(direction)")
    mapTranslate.damping=speed
    mapTranslate.stiffness=0
    mapTranslate.mass=1
    mapTranslate.fromValue = 0
    mapTranslate.toValue=distance
    view.layer.addAnimation(mapTranslate, forKey: mapTranslate.keyPath)
    view.transform=CGAffineTransformTranslate(view.transform, distance,0)
    
    
}
func viewCurlUp(view:UIView,animationTime:Float)
{
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
    UIView.setAnimationDuration(NSTimeInterval(animationTime))
    UIView.setAnimationTransition(UIViewAnimationTransition.CurlUp, forView: view, cache: false)
    
    UIView.commitAnimations()
}

func viewCurlDown(view:UIView,animationTime:Float)
{
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
    UIView.setAnimationDuration(NSTimeInterval(animationTime))
    UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: view, cache: false)
    
    UIView.commitAnimations()
}

func viewFlipFromLeft(view:UIView,animationTime:Float)
{
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
    UIView.setAnimationDuration(NSTimeInterval(animationTime))
    UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: view, cache: false)
    
    UIView.commitAnimations()
}

func viewFlipFromRight(view:UIView,animationTime:Float)
{
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
    UIView.setAnimationDuration(NSTimeInterval(animationTime))
    UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: view, cache: false)
    
    UIView.commitAnimations()
}

func viewMoveInFromTop(view:UIView,animationTime:Float)
{
    var animation:CATransition = CATransition()
    animation.duration = CFTimeInterval(animationTime)
    animation.type = "moveIn"
    animation.timingFunction = CAMediaTimingFunction(name: "easeInEaseOut")
    animation.subtype = "fromBottom"
    animation.fillMode = "forwards"
    view.layer.addAnimation(animation, forKey: nil)
    
}

func animationRotationEffect(view:UIView,animationTime:Float)
{
    UIView.animateWithDuration(NSTimeInterval(animationTime), animations: { () -> Void in
        
        var animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        animation.toValue = NSValue(CATransform3D:CATransform3DMakeRotation(CGFloat(M_PI/2), -1, 0, 0))
        
        animation.duration = CFTimeInterval(animationTime)
        animation.cumulative = true
        animation.repeatCount  = 2
        
        view.layer.addAnimation(animation, forKey: nil)
    })
}

func animationScaleEffect(view:UIView,animationTime:Float)
{
    UIView.animateWithDuration(NSTimeInterval(animationTime), animations: {
        
        view.transform = CGAffineTransformMakeScale(0.001, 0.001)
        
        },completion:{completion in
            UIView.animateWithDuration(NSTimeInterval(animationTime), animations: { () -> Void in
                
                view.transform = CGAffineTransformMakeScale(1, 1)
            })
    })
    
}
func insertBlurView (view: UIView,  style: UIBlurEffectStyle) {
    var blurEffect = UIBlurEffect(style: style)
    var blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    view.addSubview(blurEffectView)
}


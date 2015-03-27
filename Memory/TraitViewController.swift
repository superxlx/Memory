//
//  TraitViewController.swift
//  Memory
//
//  Created by xlx on 15/3/27.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit

class TraitViewController: UIViewController {
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        var trait:UITraitCollection!
        if size.width > 414 {
            if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
                trait=UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            }else{
                trait=UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            }
            
        }else{
            trait=UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Compact)
        }
        setOverrideTraitCollection(trait, forChildViewController: childViewControllers.first as UIViewController)
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
    }
}

//
//  Remind.swift
//  Memory
//
//  Created by xlx on 15/4/7.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import Foundation
import CoreData

class Remind: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var date: NSDate

}

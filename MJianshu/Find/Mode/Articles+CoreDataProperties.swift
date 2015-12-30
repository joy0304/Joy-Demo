//
//  Articles+CoreDataProperties.swift
//  MJianshu
//
//  Created by wjl on 15/12/30.
//  Copyright © 2015年 Martin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Articles {

    @NSManaged var userName: String?
    @NSManaged var articleTitle: String?
    @NSManaged var previewImageStr: String?
    @NSManaged var timeValue: String?
    @NSManaged var readNumber: NSNumber?
    @NSManaged var commentNumber: NSNumber?
    @NSManaged var favorNumber: NSNumber?

}

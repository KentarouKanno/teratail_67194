//
//  Person+CoreDataProperties.swift
//  teratail_67194
//
//  Created by Kentarou on 2017/02/27.
//  Copyright © 2017年 Kentarou. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var time: NSDate?

}

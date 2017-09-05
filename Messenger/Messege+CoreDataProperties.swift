//
//  Messege+CoreDataProperties.swift
//  Messenger
//
//  Created by Phoenix on 26.05.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import Foundation
import CoreData


extension Messege {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messege> {
        return NSFetchRequest<Messege>(entityName: "Messege");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var friend: Friend?

}

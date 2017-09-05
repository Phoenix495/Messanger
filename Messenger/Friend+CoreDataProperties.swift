//
//  Friend+CoreDataProperties.swift
//  Messenger
//
//  Created by Phoenix on 26.05.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend");
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImageName: String?
    @NSManaged public var messeges: NSSet?

}

// MARK: Generated accessors for messeges
extension Friend {

    @objc(addMessegesObject:)
    @NSManaged public func addToMesseges(_ value: Messege)

    @objc(removeMessegesObject:)
    @NSManaged public func removeFromMesseges(_ value: Messege)

    @objc(addMesseges:)
    @NSManaged public func addToMesseges(_ values: NSSet)

    @objc(removeMesseges:)
    @NSManaged public func removeFromMesseges(_ values: NSSet)

}

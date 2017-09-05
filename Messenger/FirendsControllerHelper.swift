//
//  FirendsControllerHelper.swift
//  Messenger
//
//  Created by Phoenix on 26.05.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import UIKit
import CoreData

/*class Friend: NSObject {
    var name: String?
    var profileImageName: String?
}

class Messege: NSObject {
    var text: String?
    var date: NSDate?
    
    var friend: Friend?
}
*/

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                let entityNames = ["Friend", "Messege"]
                
                for entityName in entityNames {
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try(context.fetch(fetchRequest) as? [NSManagedObject])
                    
                    for object in objects! {
                        context.delete(object)
                    }
 
                }

                
                try(context.save())
                
            }catch let err {
                print(err)
            }
        }

    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let panda1 = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            panda1.name = "Panda"
            panda1.profileImageName = "panda"
            
            createMessageWithText(text: "Только панда только хардкор...", friend: panda1, minutesAgo: 1, context: context)
            
            let rembrand = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            rembrand.name = "Rembrand"
            rembrand.profileImageName = "rembrand"
            
            createMessageWithText(text: "Привіт, мене звати Рембранд, я художник...", friend: rembrand, minutesAgo: 3.0, context: context)
            createMessageWithText(text: "Як твої справи?...", friend: rembrand, minutesAgo: 2.0, context: context)
            createMessageWithText(text: "Про що ти б хотів поговорити зі мною...", friend: rembrand, minutesAgo: 1.0, context: context)

            let phoenix = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            phoenix.name = "Phoenix"
            phoenix.profileImageName = "phoenix"
            
            createMessageWithText(text: "Привіт, що поробляєш?..", friend: phoenix, minutesAgo: 60 * 24, context: context)
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve"
            
            createMessageWithText(text: "Дуже приємно, нарешті познайомитись))..", friend: steve, minutesAgo: 10 * 60 * 24, context: context)
            
            
    
            do {
                try(context.save())
            }catch let err {
                print(err)
            }
            
            //    messeges = [messege, messegeRembrand]

        }
            loadData()
    }
    
    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Messege", into: context) as! Messege
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
        
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate

        if let context = delegate?.persistentContainer.viewContext {
           
            if let friends = fetchFriends() {
                
                messages = [Messege]()

                for friend in friends {
                    print(friend.name!)
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Messege")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessages = try(context.fetch(fetchRequest)) as? [Messege]
                        messages?.append(contentsOf: fetchedMessages!)
                        
                    }catch let err {
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date as! Date) == .orderedDescending})
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do {
              
                return try context.fetch(request) as? [Friend]
                
            } catch let err {
                print(err)
            }
        }
        
        return nil
    }
}

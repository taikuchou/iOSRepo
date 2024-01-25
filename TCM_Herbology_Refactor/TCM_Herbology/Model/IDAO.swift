//
//  IDAO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import Foundation
import CoreData

protocol IDAO{
    associatedtype T
    func checkInit() -> Bool
    func save(vo: T, hid: Int)
    var managedContext: NSManagedObjectContext{get}
    var entityName: String{get}
}

extension IDAO {
    func checkInit() -> Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            let list: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            return list.count != 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return true
    }
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

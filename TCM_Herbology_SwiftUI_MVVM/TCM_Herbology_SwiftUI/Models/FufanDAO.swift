//
//  FufanDAO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import CoreData
import UIKit
import SwiftUI
class FufanDAO: IDAO {
    var managedContext: NSManagedObjectContext? {
        get {
            return _managedContext
        }
        set{
            if let newValue{
                _managedContext = newValue
            }
        }
    }
    var _managedContext: NSManagedObjectContext?
    let ENTITY_NAME = "FufanEntity"
    var entityName: String{
        return ENTITY_NAME
    }
    private static let _inst = FufanDAO()
    static var shared: FufanDAO {
        return _inst
    }

    private init(){
        
    }

    func save(vo: FufanVO, hid: Int = 0) {
        if let managedContext {
            let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
            let herb = NSManagedObject(entity: entity,
                                       insertInto: managedContext)

            herb.setValue(vo.url, forKeyPath: "url")
            herb.setValue(vo.name, forKeyPath: "name")
            herb.setValue(vo.desc, forKeyPath: "desc")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save fufan. \(error), \(error.userInfo)")
            }
        }
    }
    func getURL(_ name: String) -> String {
        if let managedContext {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "name == %@ ", name);
            do {
                let fufans: [NSManagedObject] = try managedContext.fetch(fetchRequest)
                if(!fufans.isEmpty){
                    let fufan = FufanVO.fromNSManagedObject(fufans[0])
                    return fufan.url
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        return ""
    }
    func getResultByKey(key:String? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        return try? managedContext?.fetch(fetchRequest)
    }
    
}


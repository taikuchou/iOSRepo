//
//  FufanDAO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import CoreData
import UIKit

class FufanDAO: IDAO {
    let ENTITY_NAME = "FufanEntity"
    var entityName: String{
        return ENTITY_NAME
    }
    private static let _inst = FufanDAO()
    static var shared: FufanDAO {
        return _inst
    }
    private var _managedContext: NSManagedObjectContext!
    var managedContext: NSManagedObjectContext{
        return _managedContext
    }
    private init(){
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        _managedContext =
        appDelegate.persistentContainer.viewContext
    }

    func save(vo: FufanVO, hid: Int = 0) {
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
    func getURL(_ name: String) -> String {
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
        return ""
    }
}


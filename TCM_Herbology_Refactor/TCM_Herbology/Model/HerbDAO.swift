//
//  HerbDAO.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/25.
//

import CoreData
import UIKit

class HerbDAO: IDAO {
    let ENTITY_NAME = "HerbEntity"
    var entityName: String{
        return ENTITY_NAME
    }
    private static let _inst = HerbDAO()
    static var shared: HerbDAO {
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
    
    func save(vo: HerbVO, hid: Int) {
        let entity =
        NSEntityDescription.entity(forEntityName: entityName,
                                   in: managedContext)!
        let herb = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

        herb.setValue(hid, forKeyPath: "hid")
        herb.setValue(vo.url, forKeyPath: "url")
        herb.setValue(vo.group, forKeyPath: "group")
        herb.setValue(vo.category, forKeyPath: "category")
        herb.setValue(vo.efficacy, forKeyPath: "efficacy")
        herb.setValue(vo.subgroup1, forKeyPath: "subgroup1")
        herb.setValue(vo.subgroup2, forKeyPath: "subgroup2")
        herb.setValue(vo.pinyinName, forKeyPath: "pinyinName")
        herb.setValue(vo.chName, forKeyPath: "name")
        herb.setValue(vo.latinName, forKeyPath: "latinName")
        herb.setValue(vo.properties, forKeyPath: "properties")
        herb.setValue(vo.channels, forKeyPath: "channels")
        herb.setValue(vo.actionsIndications, forKeyPath: "actionsIndications")
        herb.setValue(vo.dosage, forKeyPath: "dosage")
        herb.setValue(vo.commonName, forKeyPath: "commonName")
        herb.setValue(vo.literalEnglish, forKeyPath: "literalEnglish")
        herb.setValue(vo.contraindicationsCautions, forKeyPath: "contraindicationsCautions")
        herb.setValue(vo.commonCombinations, forKeyPath: "commonCombinations")
        herb.setValue(vo.others, forKeyPath: "others")
        herb.setValue(vo.fuFan, forKeyPath: "fuFan")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

    func getResultByGroupAndKey(group: String? = nil, key:String? = nil) -> [NSManagedObject]? {
        var count = 0
        if let group {
            count += 1
        }
        if let key {
            count += 2
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        switch count{
        case 1:
            if let group{
                fetchRequest.predicate = NSPredicate(format: "group == %@ ", group);
            }
        case 2:
            if let key{
                let nkey = "*\(key)*"
                fetchRequest.predicate = NSPredicate(format: "name like %@ or category like %@ or pinyinName like %@ or latinName like %@", nkey, nkey, nkey, nkey);
            }
        case 3:
            if let group, let key{
                let nkey = "*\(key)*"
                fetchRequest.predicate = NSPredicate(format: "group == %@ and (name like %@ or category like %@ or pinyinName like %@ or latinName like %@)", group, nkey, nkey, nkey, nkey);
            }
        default:
            break
        }
        return try? managedContext.fetch(fetchRequest)
    }
    func getResultByKey(key:String? = nil) -> [NSManagedObject]? {
        return getResultByGroupAndKey(key:key)
    }
}

//
//  AppDelegate.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var HerbList: [HerbVO] = []
    let GET_LINK = "https://taikuchou.github.io/tcmdafan.json"

    func checkInit() -> Bool{
        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HerbEntity")

        do {
            let herbs: [NSManagedObject] = try managedContext.fetch(fetchRequest)
//            print(herbs.count)
            return herbs.count != 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return true
    }
    func getData_GET(){
        let isAdd = checkInit()
        if isAdd {
            return
        }
        if let url = URL(string: GET_LINK){
            let session = URLSession.shared
            session.dataTask(with: URLRequest(url: url)) { data, res, error in
                if let error{
                    print(error)
                    return
                }
                if let data, let string = String(data: data, encoding: .utf8){
                    print(string.count)
//                    DispatchQueue.main.async {
//                        self.display.text = "\(string.count)"
//                    }
//                    if let jsonArray  = try? JSONSerialization.jsonObject(with:data,options:JSONSerialization.ReadingOptions.mutableContainers), let list = jsonArray as? [[String:String]]{
//                        print(list.count)
//
//                    }
                    if let array = try? JSONDecoder().decode([HerbVO].self, from: data){
                        //print(array.count)
                        AppDelegate.HerbList = array
                        print(AppDelegate.HerbList.count)
                        DispatchQueue.main.async {
                            var id = 1;
                            for data in AppDelegate.HerbList {

                                self.save(vo: data, hid: id)

                                id += 1
                            }
                        }
                        
                    }
                }
            }.resume()
        }
    }

    func save(vo: HerbVO, hid: Int) {

        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let managedContext =
        appDelegate.persistentContainer.viewContext

        // 2
        let entity =
        NSEntityDescription.entity(forEntityName: "HerbEntity",
                                   in: managedContext)!

        let herb = NSManagedObject(entity: entity,
                                   insertInto: managedContext)

        // 3
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
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getData_GET()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TCM_Herbology")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


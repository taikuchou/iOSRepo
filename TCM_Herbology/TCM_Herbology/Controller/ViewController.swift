//
//  ViewController.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/22.
//

import UIKit
import CoreData

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class ViewController: UIViewController {
    let num: CGFloat = 10
    var managedContext: NSManagedObjectContext!
    var lists = [HerbVO]()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    func initHerbList(_ key: String? = nil){
        lists.removeAll()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "HerbEntity")
        var gSet = Set<String>()
        if let key{
            let nkey = "*\(key)*"
            fetchRequest.predicate = NSPredicate(format: "name like %@ or category like %@ or pinyinName like %@ or latinName like %@", nkey, nkey, nkey, nkey);
        }
        do {
            let herbs: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            for data in herbs{
                var herb = HerbVO()
                herb = herb.fromNSManagedObject(data)
                lists.append(herb)
                gSet.insert(herb.group)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func initCoreData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Herbs"
        initCoreData()
        initHerbList()
        initCollectionView()

    }

    func initCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: num).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -num).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        //        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var count: CGFloat = 2
        if UIDevice.current.orientation.isLandscape  || UIDevice.current.orientation.isFlat {
            count = 5
        }
        let width = (collectionView.frame.width - num)/count
        let height = width
        return CGSize(width: width , height: height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.lists[indexPath.item]
        return cell
    }
    
}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        details
        if let next = self.storyboard?.instantiateViewController(withIdentifier: "details") as? HerbDetailsViewController {
            next.data = self.lists[indexPath.item]
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
}

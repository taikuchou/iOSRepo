//
//  MainViewModel.swift
//  TCM_Herbology_SwiftUI_MVVVM
//
//  Created by Tai Kuchou on 2024/1/26.
//

import Foundation
import CoreData
final class MainViewModel: ObservableObject {
    let links = ["All","Group"]
    @Published var searchHidden = true
    @Published var key = ""{
        didSet{
            updateStatus(searchHidden,key,selectedIndex)
        }
    }
    @Published var selectedIndex = 0{
        didSet{
            updateStatus(searchHidden,key,selectedIndex)
        }
    }
    @Published var list = [HerbVO]()
    @Published var glists = [String]()
    @Published var gdatalists = [[HerbVO]]()
    init(key: String = "", selectedIndex: Int = 0, list: [HerbVO] = [HerbVO](), glists: [String] = [String](), gdatalists: [[HerbVO]] = [[HerbVO]]()) {
//        self.key = key
//        self.selectedIndex = selectedIndex
        self.list = list
        self.glists = glists
        self.gdatalists = gdatalists
        updateStatus()
    }
    func LinkString(selectedIndex: Int) -> String {
        return links[selectedIndex]
    }
    func updateStatus(_ searchHidden:Bool = true,_ key:String = "", _ selectedIndex: Int = 0){
        var _list = [HerbVO]()
        var _gdatalists = [[HerbVO]]()
        var skey: String?
        var gSet = Set<String>()
        if !key.isEmpty {
            skey = key
        }
        if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByKey(key:skey) {
            for data in herbs{
                let herb = HerbVO.fromNSManagedObject(data)
                _list.append(herb)
                gSet.insert(herb.group)
            }
            list = _list
            glists = gSet.sorted()
            if selectedIndex == 1 {
                for idx in 0..<glists.count{
                    let group = glists[idx]
                    var list1 = [HerbVO]()
                    if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByGroupAndKey(group: group, key: skey){
                        for data in herbs{
                            let herb = HerbVO.fromNSManagedObject(data)
                            list1.append(herb)
                        }
                        _gdatalists.append(list1)
                    }
                }
                gdatalists = _gdatalists
            }
            print(list.count, glists.count, gdatalists.count)
        }
    }
}

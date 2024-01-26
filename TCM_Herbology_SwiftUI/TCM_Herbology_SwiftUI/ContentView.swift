//
//  ContentView.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var searchHidden = true
    @State var key = ""
    let links = ["All","Group"]
    @State var selectedIndex = 0
    var LinkString: String {
        return links[selectedIndex]
    }
    var body: some View {
        return listSectionView
    }
    var listSectionView: some View{
        var list = [HerbVO]()
        var glists = [String]()
        var gdatalists = [[HerbVO]]()
        var skey: String?
        var gSet = Set<String>()
        if !key.isEmpty {
            skey = key
        }
        if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByKey(key:skey) {
            for data in herbs{
                let herb = HerbVO.fromNSManagedObject(data)
                list.append(herb)
                gSet.insert(herb.group)
            }
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
                        gdatalists.append(list1)
                    }
                }
            }
//            print(list.count, glists.count, gdatalists.count)
        }
        return NavigationView {
            List {
                if !searchHidden{
                    HStack{
                        TextField(
                            "",
                            text: $key
                        )
                    }.border(.secondary, width: 1)
                        .cornerRadius(2)
                }
                if selectedIndex == 0 {
                    ForEach(list,id:\.hid) { data in
                        MainNavigationLinkView(data: data)
                    }
                }else{
                    ForEach(0..<glists.count,id:\.self) { row in
                        let data = glists[row]
                        let clist = gdatalists[row]
                        Section(header: Text(data), footer: Text("Total: \(clist.count)").foregroundColor(Color.secondary)){
                            ForEach(clist,id:\.hid) { hdata in
                                MainNavigationLinkView(data: hdata)
                            }
                        }
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Herbs")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {
                    searchHidden = !searchHidden
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
            }
            )
            .navigationBarItems(leading:
                                    HStack {
                Picker(selection: $selectedIndex) {
                    ForEach(0..<links.count,id:\.self) { idx in
                        Text(links[idx])
                    }
                } label: {
                    Text("Options")
                }
                .labelsHidden()
                .pickerStyle(.segmented)
            }
            )
        }

    }
    var listAllView: some View{
        var list = [HerbVO]()
        var skey: String?
        if !key.isEmpty {
            skey = key
        }
        if let herbs: [NSManagedObject] = HerbDAO.shared.getResultByKey(key:skey) {
            for data in herbs{
                let herb = HerbVO.fromNSManagedObject(data)
//                print(list.count, herb.hid)
                list.append(herb)
            }
        }
//        print(list.count, list[0].hid)
        return NavigationView {
            List {
                if !searchHidden{
                    HStack{
                        TextField(
                            "",
                            text: $key
                        )
                    }.border(.secondary, width: 1)
                        .cornerRadius(2)
                }
                ForEach(list,id:\.hid) { data in
                    NavigationLink {
                        HerbDetailContent(data: data)
                    } label: {
                        MainCellView(data: data)
                    }
                }

            }
            .listStyle(.plain)
            .navigationTitle("Herbs")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {
                    searchHidden = !searchHidden
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
            }
            )
            .navigationBarItems(leading:
                                    HStack {
                Picker(selection: $selectedIndex) {
                    ForEach(0..<links.count,id:\.self) { idx in
                        Text(links[idx])
                    }
                } label: {
                    Text("Options")
                }
                .labelsHidden()
                .pickerStyle(.segmented)
            }
            )
        }

    }
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

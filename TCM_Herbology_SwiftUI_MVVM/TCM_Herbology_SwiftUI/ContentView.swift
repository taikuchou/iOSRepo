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
    @EnvironmentObject var viewModel: MainViewModel
    @State var isGrid = false
    var body: some View {

        return NavigationView {
            if isGrid{
                VStack{
                    CustomCollectionView()
                    Spacer()
                }.navigationTitle("Herb Collection View")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading:
                                            HStack {
                        Button(action: {
                            isGrid = !isGrid
                        }) {
                            Text("< Back").foregroundColor(Color.blue)
                        }
                    }
                    )
            }else{
                List {

                    if !viewModel.searchHidden{
                        HStack{
                            TextField(
                                "",
                                text: $viewModel.key
                            )
                        }.border(.secondary, width: 1)
                            .cornerRadius(2)
                    }
                    if viewModel.selectedIndex == 0 {
                        ForEach(viewModel.list,id:\.hid) { data in
                            MainNavigationLinkView(data: data)
                        }
                    }else{
                        ForEach(0..<viewModel.glists.count,id:\.self) { row in
                            let data = viewModel.glists[row]
                            let clist = viewModel.gdatalists[row]
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
                        isGrid = !isGrid
                    }) {
                        Image(systemName: "grid")
                            .imageScale(.large)
                    }
                    Button(action: {
                        viewModel.searchHidden = !viewModel.searchHidden
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                    }
                }
                )
                .navigationBarItems(leading:
                                        HStack {
                    Picker(selection: $viewModel.selectedIndex) {
                        ForEach(0..<viewModel.links.count,id:\.self) { idx in
                            Text(viewModel.LinkString(selectedIndex: idx))
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

    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

//
//  TCM_Herbology_SwiftUIApp.swift
//  TCM_Herbology_SwiftUI
//
//  Created by Tai Kuchou on 2024/1/24.
//

import SwiftUI

@main
struct TCM_Herbology_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  UserListDataApp.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//

import SwiftUI

@main
struct UserListDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

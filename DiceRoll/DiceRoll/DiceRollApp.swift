//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI

@main
struct DiceRollApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

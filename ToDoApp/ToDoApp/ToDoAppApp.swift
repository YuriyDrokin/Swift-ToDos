//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Yuriy Drokin on 2023-08-24.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

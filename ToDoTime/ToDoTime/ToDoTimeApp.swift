//
//  ToDoTimeApp.swift
//  ToDoTime
//
//  Created by Ali Hooshmand on 2.03.2025.
//

import SwiftUI

@main
struct ToDoTimeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

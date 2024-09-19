//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 07.09.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Text("To-Do List")
                .fontWeight(.bold)
                .font(.title)
            
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

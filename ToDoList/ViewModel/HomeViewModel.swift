//
//  HomeViewModel.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var filterDate: Date = .init()
    @Published var showPendingTasks: Bool = true
    @Published var showCompletedTasks: Bool = true
    @Published var isSaveFilePickerPresented = false
    @Published var isLoadFilePickerPresented = false
    @Published var isKeyboardVisible = false
    
    private var env: EnvironmentValues
    
    init(env: EnvironmentValues) {
        self.env = env
    }
    
    func addNewTask() {
        do {
            let task = Task(context: env.managedObjectContext)
            task.id = .init()
            task.date = filterDate
            task.title = ""
            task.isCompleted = false
            
            try env.managedObjectContext.save()
            showPendingTasks = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTasks() -> [TaskCodable] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let tasks = try env.managedObjectContext.fetch(fetchRequest)
            return tasks.map { TaskCodable(id: $0.id, title: $0.title, date: $0.date, isCompleted: $0.isCompleted) }
        } catch {
            print("Ошибка получения задач: \(error.localizedDescription)")
            return []
        }
    }
    
    func importTasks(_ tasks: [TaskCodable]) {
        let context = env.managedObjectContext
        for task in tasks {
            let newTask = Task(context: context)
            newTask.id = task.id
            newTask.title = task.title
            newTask.date = task.date
            newTask.isCompleted = task.isCompleted ?? false
        }
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения задач: \(error.localizedDescription)")
        }
    }
}

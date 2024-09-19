//
//  TaskCodable.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 10.09.2024.
//

import SwiftUI
import CoreData

struct TaskCodable: Codable {
    var id: UUID?
    var title: String?
    var date: Date?
    var isCompleted: Bool?
}



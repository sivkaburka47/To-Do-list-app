//
//  TaskFileDocument.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct TaskFileDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    var tasks: [TaskCodable] = []

    init(tasks: [TaskCodable] = []) {
        self.tasks = tasks
    }

    init(configuration: ReadConfiguration) throws {
        let data = configuration.file.regularFileContents ?? Data()
        self.tasks = try JSONDecoder().decode([TaskCodable].self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(tasks)
        return FileWrapper(regularFileWithContents: data)
    }
}

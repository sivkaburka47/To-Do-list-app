//
//  TaskListView.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI

struct TaskListView: View {
    @Binding var filterDate: Date
    @Binding var showPendingTasks: Bool
    @Binding var showCompletedTasks: Bool
    
    var body: some View {
        List {
            CustomFilteringDataView(filterDate: $filterDate) { pendingTasks, completedTasks in
                DisclosureGroup(isExpanded: $showPendingTasks) {
                    if pendingTasks.isEmpty {
                        Text("Задачи отсутствуют")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(pendingTasks) {
                            TaskRow(task: $0, isPendingTask: true)
                        }
                    }
                } label: {
                    Text("Нерешенные задачи \(pendingTasks.isEmpty ? "" : "(\(pendingTasks.count))")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .accentColor(Color(red: 0.36, green: 0.05, blue: 0.9))
                
                DisclosureGroup(isExpanded: $showCompletedTasks) {
                    if completedTasks.isEmpty {
                        Text("Задачи отсутствуют")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(completedTasks) {
                            TaskRow(task: $0, isPendingTask: false)
                        }
                    }
                } label: {
                    Text("Решенные задачи \(completedTasks.isEmpty ? "" : "(\(completedTasks.count))")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .accentColor(Color(red: 0.36, green: 0.05, blue: 0.9))
            }
        }
        .listStyle(PlainListStyle())
        .listRowInsets(EdgeInsets())
        .frame(maxWidth: .infinity)
    }
}

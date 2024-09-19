//
//  TaskRow.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task
    var isPendingTask: Bool
    @Environment(\.self) private var env
    @FocusState private var showKeyboard: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                task.isCompleted.toggle()
                save()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundColor(Color(red: 0.36, green: 0.05, blue: 0.9))
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Я хочу...", text: .init(get: {
                    return task.title ?? ""
                }, set: { value in
                    task.title = value
                }))
                .focused($showKeyboard)
                .onSubmit {
                    removeEmptyTask()
                    save()
                }
                .foregroundColor(isPendingTask ? .primary : .gray)
                .strikethrough(!isPendingTask, pattern: .dash, color: .primary)
                
                Text((task.date ?? .init()).formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .foregroundColor(timeColor(for: task.date ?? .init()))
                    .overlay {
                        DatePicker(selection: .init(get: {
                            return task.date ?? .init()
                        }, set: { value in
                            task.date = value
                            save()
                        }), displayedComponents: [.hourAndMinute]) {
                            
                        }
                        .labelsHidden()
                        .blendMode(.destinationOver)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            if (task.title ?? "").isEmpty {
                showKeyboard = true
            }
        }
        .onDisappear {
            removeEmptyTask()
            save()
        }
        .onChange(of: env.scenePhase) { newValue in
            if newValue != .active {
                showKeyboard = false
                DispatchQueue.main.async {
                    removeEmptyTask()
                    save()
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    env.managedObjectContext.delete(task)
                    save()
                }
            } label: {
                Image(systemName: "trash.fill")
            }
        }
    }
    
    func save() {
        do {
            try env.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeEmptyTask() {
        if (task.title ?? "").isEmpty {
            env.managedObjectContext.delete(task)
        }
    }
    
    func timeColor(for date: Date) -> Color {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 6..<13:
            return Color(red: 1.0 / 255.0, green: 179.0 / 255.0, blue: 131.0 / 255.0)
        case 13..<23:
            return Color(red: 0.36, green: 0.05, blue: 0.9)
        default:
            return Color(.blue)
        }
    }
}

//
//  Home.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 07.09.2024.
//

import SwiftUI
import UniformTypeIdentifiers
import CoreData
import MobileCoreServices

struct Home: View {
    @Environment(\.self) private var env
    @StateObject private var viewModel: HomeViewModel
    
    init(env: EnvironmentValues) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(env: env))
    }
    
    var body: some View {
        VStack {
            HeaderView(filterDate: $viewModel.filterDate, isKeyboardVisible: $viewModel.isKeyboardVisible)
                .environment(\.locale, Locale(identifier: "ru_RU"))
                .padding(.horizontal, 0)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    withAnimation {
                        viewModel.isKeyboardVisible = true
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                    withAnimation {
                        viewModel.isKeyboardVisible = false
                    }
                }
            
            TaskListView(filterDate: $viewModel.filterDate, showPendingTasks: $viewModel.showPendingTasks, showCompletedTasks: $viewModel.showCompletedTasks)
            
            FooterView(isSaveFilePickerPresented: $viewModel.isSaveFilePickerPresented, isLoadFilePickerPresented: $viewModel.isLoadFilePickerPresented, addNewTask: viewModel.addNewTask)
                .fileImporter(isPresented: $viewModel.isLoadFilePickerPresented, allowedContentTypes: [.json]) { result in
                    do {
                        let fileURL = try result.get()
                        let fileManager = FileManager.default
                        if !fileManager.isReadableFile(atPath: fileURL.path) {
                            print("Нет прав на чтение файла")
                            return
                        }
                        
                        var error: NSError?
                        NSFileCoordinator().coordinate(readingItemAt: fileURL, error: &error) { url in
                            do {
                                let data = try Data(contentsOf: url)
                                let tasks = try JSONDecoder().decode([TaskCodable].self, from: data)
                                viewModel.importTasks(tasks)
                            } catch {
                                print("Ошибка чтения файла: \(error.localizedDescription ?? "Неизвестная ошибка")")
                            }
                        }
                        
                        if let error = error {
                            print("Ошибка координации доступа к файлу: \(error.localizedDescription)")
                        }
                        
                    } catch {
                        print("Ошибка выбора файла: \(error.localizedDescription)")
                    }
                }
                .fileExporter(isPresented: $viewModel.isSaveFilePickerPresented, document: TaskFileDocument(tasks: viewModel.fetchTasks()), contentType: .json, defaultFilename: "tasks") { result in
                    switch result {
                    case .success(let url):
                        print("Файл сохранен по адресу: \(url)")
                    case .failure(let error):
                        print("Ошибка сохранения файла: \(error.localizedDescription)")
                    }
                }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.clear)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}

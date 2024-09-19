//
//  FooterView.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI

struct FooterView: View {
    @Binding var isSaveFilePickerPresented: Bool
    @Binding var isLoadFilePickerPresented: Bool
    var addNewTask: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                GeometryReader { geometry in
                    Menu {
                        Button("Сохранить задачи в JSON") {
                            isSaveFilePickerPresented = true
                        }
                        Button("Загрузить задачи из JSON") {
                            isLoadFilePickerPresented = true
                        }
                    } label: {
                        Image(systemName: "gear")
                            .font(.title3)
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                            .bold()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .frame(width: 44, height: 44)
                
                Spacer()
                
                Button {
                    addNewTask()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 70, height: 70)
                    .background(Circle().foregroundColor(Color(red: 0.36, green: 0.05, blue: 0.9)))
                    .offset(y: -20)
                }
                
                Spacer()
                
                GeometryReader { geometry in
                    Button(action: {
                        // сделать колокольчик action когда будет время, возможно будет, возможно и нет :)
                        
                    }) {
                        Image(systemName: "bell")
                            .font(.title3)
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                            .bold()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .frame(width: 44, height: 44)
                
                Spacer()
            }
            .padding(.bottom, 10)
            .background(
                TabBarShape()
                    .fill(Color(red: 0.07, green: 0.07, blue: 0.16))
                    .shadow(radius: 5)
            )
            .frame(height: 60)
        }
    }
}

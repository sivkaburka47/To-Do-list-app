//
//  HeaderView.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 14.09.2024.
//

import SwiftUI

struct HeaderView: View {
    @Binding var filterDate: Date
    @Binding var isKeyboardVisible: Bool
    
    var body: some View {
        VStack {
            if isKeyboardVisible {
                
            } else {
                DatePicker(selection: $filterDate, displayedComponents: [.date]) {
                    
                }
                .labelsHidden()
                .datePickerStyle(.graphical)
                .padding()
                .accentColor(Color(red: 0.36, green: 0.05, blue: 0.9))
            }
        }
    }
}

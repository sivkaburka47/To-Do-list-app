//
//  ContentView.swift
//  ToDoList
//
//  Created by Станислав Дейнекин on 07.09.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.self) private var env
    
    var body: some View {
        NavigationStack {
            Home(env: env)
        }
    }
}

#Preview {
    ContentView()
}

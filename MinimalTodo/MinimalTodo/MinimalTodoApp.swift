//
//  MinimalTodoApp.swift
//  MinimalTodo
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import SwiftUI

@main
struct MinimalTodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}

//
//  ContentView.swift
//  MinimalTodo
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}

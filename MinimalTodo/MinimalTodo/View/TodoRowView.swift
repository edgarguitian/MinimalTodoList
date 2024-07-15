//
//  TodoRowView.swift
//  MinimalTodo
//
//  Created by Edgar Guitian Rey on 15/7/24.
//

import SwiftUI

struct TodoRowView: View {
    @Bindable var todo: Todo
    @FocusState private var isActive: Bool
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var phase
    var body: some View {
        HStack(spacing: 0) {
            if !isActive && !todo.task.isEmpty {
                Button(action: {
                    todo.isCompleted.toggle()
                    todo.lastUpdated = .now
                }, label: {
                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(todo.isCompleted ? .gray : .accentColor)
                        .contentTransition(.symbolEffect(.replace))
                })
            }
            
            TextField("Record Video", text: $todo.task)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(todo.isCompleted ? .gray : .primary)
                .focused($isActive)
            
            if !isActive && !todo.task.isEmpty {
                /// Priority Menu Button (For Updating)
                Menu {
                    ForEach(Priority.allCases, id: \.rawValue) { priority in
                        Button(action: {
                            todo.priority = priority
                        }, label: {
                            HStack {
                                Text(priority.rawValue)
                                
                                if todo.priority == priority {
                                    Image(systemName: "checkmark")
                                }
                            }
                        })
                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.title2)
                        .padding(3)
                        .contentShape(.rect)
                        .foregroundStyle(todo.priority.color.gradient)
                }
            }
        }
        .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
        .animation(.snappy, value: isActive)
        .onAppear {
            isActive = todo.task.isEmpty
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("", systemImage: "trash") {
                context.delete(todo)
            }
            .tint(.red)
        }
        .onSubmit {
            if todo.task.isEmpty {
                /// Deleting Empty Todo
                context.delete(todo)
            }
        }
        .onChange(of: phase) { oldValue, newValue in
            if newValue != .active && todo.task.isEmpty {
                context.delete(todo)
            }
        }
    }
}

#Preview {
    ContentView()
}
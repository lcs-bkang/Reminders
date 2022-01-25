//
//  ContentView.swift
//  Shared
//
//  Created by Brad Kang on 2022-01-20.
//

import SwiftUI

struct ContentView: View {
    
    // Stores all tasks
    @ObservedObject var store: TaskStore
    
    // Control whether the add task is showing
    @State private var showingAddTask = false
    
    // Whether to show completed tasks or not
    @State var showingCompletedTask = true
    
    var body: some View {
        List {
            ForEach(store.tasks) { task in
                
                if showingCompletedTask {
                    // Show all tasks
                    TaskCell(task: task)
                } else {
                    
                    // Only show incomplete tasks
                    if task.completed == false {
                        TaskCell(task: Task)
                    }
                    
                }
            }
            // View modifiers invokes the function of the view model, "store"
            .onDelete(perform: store.deleteItem)
            .onMove(perform: store.moveItems)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
            ToolbarItem(placement: .bottomBar) {
                // Ternary operators work as following
                // (Value) ? (Show when value is true) : (Show when value is false)
                Button(showingCompletedTask ? "Hide completedtasks" : "Show completed tasks") {
                    print("Value of showingCompletedTask was: \(showingCompletedTask)")
                    showingCompletedTask.toggle()
                    print("Value of showingCompletedTask is now: \(showingCompletedTask)")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTask(store: store, showing: $showingAddTask)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView(store: testStore)
        }
    }
}

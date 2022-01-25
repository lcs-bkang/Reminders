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
    
    // Wheter to re-compute the view to show changes in the list
    // We never actually show the value, but toggle it
    // From true to false and vice versa makes SwiftUI update the UI
    // This is because a property with @State has changed
    @State var listShouldUpdate = false
    
    var body: some View {
        let _ = print("listShouldUpdate has been toggled.  Current value is :\(listShouldUpdate)")
        List {
            ForEach(store.tasks) { task in
                
                if showingCompletedTask {
                    // Show all tasks
                    TaskCell(task: task, triggersUpdate: .constant(true))
                } else {
                    
                    // Only show incomplete tasks
                    if task.completed == false {
                        TaskCell(task: task, triggersUpdate: $listShouldUpdate)
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

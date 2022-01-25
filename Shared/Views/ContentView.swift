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
    
    var body: some View {
        List {
            ForEach(store.tasks) { task in
                TaskCell(task: task)
            }
            // View modifiers invokes the function of the view model, "store"
            .onDelete(perform: store.deleteItem)
        }
        .navigationTitle("Reminders")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    showingAddTask = true
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

//
//  AddTask.swift
//  Reminders
//
//  Created by Brad Kang on 2022-01-20.
//

import SwiftUI

struct AddTask: View {
    
    @ObservedObject var store: TaskStore
    
    // Source of Truth
    @State private var description = ""
    @State private var priority = TaskPriority.low
    
    // Whether to show this view
    @Binding var showing: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    Picker("Priority", selection: $priority) {
                        Text(TaskPriority.low.rawValue).tag(TaskPriority.low)
                        Text(TaskPriority.medium.rawValue).tag(TaskPriority.medium)
                        Text(TaskPriority.high.rawValue).tag(TaskPriority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        saveTask()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Dismiss the sheet by adjuting the showing property
                        // Which is a derived value which is bound to the "showingAddTask" property
                        // Which is located in ContentView, or the source of truth
                        showing = false
                    }
                }
            }
        }
        // Prevents dismissal of the sheet by swiping down
        // If the sheet is dismissed this way, data is not saved.
        // Better that we need to use the two buttons
        // So we know their intentions
        .interactiveDismissDisabled()
    }
    
    func saveTask() {
        
        // Add the task to the store
        store.tasks.append(Task(description: description, priority: priority, completed: false))
        showing = false
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask(store: testStore, showing: .constant(true))
    }
}

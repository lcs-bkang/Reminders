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
    
    // What priority of tasks to show
    @State private var selectedPriorityForVisibleTasks: VisibleTaskPriority = .all
    
    var body: some View {
        // Has the list been asked to update
        let _ = print("listShouldUpdate has been toggled.  Current value is :\(listShouldUpdate)")
        
        // What is the selected priority for task filtering
        let _ = print("Filtering tasks by this priority: \(selectedPriorityForVisibleTasks)")
        
        VStack {
            
            // Label for picker
            Text("Filter by")
                .font(Font.caption.smallCaps())
                .foregroundColor(.secondary)
            
            // Picker to allow users to select what tasks to show
            Picker("Priority", selection: $selectedPriorityForVisibleTasks) {
                Text(VisibleTaskPriority.all.rawValue)
                    .tag(VisibleTaskPriority.all)
                Text(VisibleTaskPriority.low.rawValue)
                    .tag(VisibleTaskPriority.low)
                Text(VisibleTaskPriority.medium.rawValue)
                    .tag(VisibleTaskPriority.medium)
                Text(VisibleTaskPriority.high.rawValue)
                    .tag(VisibleTaskPriority.high)
            }
            .pickerStyle(.segmented)
            List {
                ForEach(store.tasks) { task in
                    
                    if showingCompletedTask {
                        
                        if selectedPriorityForVisibleTasks == .all {
                            // Show all tasks and all priorities
                            TaskCell(task: task, triggersUpdate: .constant(true))
                        } else {
                            
                            // Only shows tasks of the selected priority
                            // Although priority and selectedPriorityForVisibleTasks are different
                            // Data types, (different enumerations) it works because we are comparing
                            // Raw values, which are both strings
                            if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                                
                                TaskCell(task: task, triggersUpdate: .constant(true))
                            }
                        }
                    } else {
                        
                        // Only show incomplete tasks
                        if task.completed == false {
                            
                            if selectedPriorityForVisibleTasks == .all {
                                
                                // Show all incompleted tasks, no matter priority
                                TaskCell(task: task, triggersUpdate: $listShouldUpdate)
                            } else {
                                if task.priority.rawValue == selectedPriorityForVisibleTasks.rawValue {
                                    
                                    TaskCell(task: task, triggersUpdate: $listShouldUpdate)
                                }
                            }
                        }
                        
                    }
                }
                // View modifiers invokes the function of the view model, "store"
                .onDelete(perform: store.deleteItem)
                .onMove(perform: store.moveItems)
            }
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

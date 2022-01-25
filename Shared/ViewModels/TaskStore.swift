//
//  TaskStore.swift
//  Reminders
//
//  Created by Brad Kang on 2022-01-20.
//

import Foundation

class TaskStore: ObservableObject {
    
    // MARK: Stored Properties
    @Published var tasks: [Task]
    
    // MARK: Initializer
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    // MARK: Functions
    func deleteItem(at offsets: IndexSet) {
        // The "offsets" contain a set of items selected for deletion
        // The set is then passed to the built-in remove method
        // This is on the "tasks" array which handles removal from the array
        tasks.remove(atOffsets: offsets)
    }
}

let testStore = TaskStore(tasks: testData)

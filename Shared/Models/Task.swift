//
//  Task.swift
//  Reminders (iOS)
//
//  Created by Brad Kang on 2022-01-20.
//

import Foundation

class Task: Identifiable, ObservableObject {
    
    var id = UUID()
    var description: String
    var priority: TaskPriority
    @Published var completed: Bool
    
    internal init(id: UUID = UUID(), description: String, priority: TaskPriority, completed: Bool) {
        self.id = id
        self.description = description
        self.priority = priority
        self.completed = completed
    }


}

let testData = [
    Task(description: "Go home", priority: .high, completed: true),
    Task(description: "Finish computer science", priority: .medium, completed: false),
    Task(description: "Go to bed", priority: .medium, completed: false)
]

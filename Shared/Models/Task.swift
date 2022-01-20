//
//  Task.swift
//  Reminders (iOS)
//
//  Created by Brad Kang on 2022-01-20.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var description: String
    var priority: TaskPriority
    var completed: Bool
}

let testData = [
    Task(description: "Go home", priority: .high, completed: true),
    Task(description: "Finish computer science", priority: .medium, completed: false),
    Task(description: "Go to bed", priority: .medium, completed: false)
]

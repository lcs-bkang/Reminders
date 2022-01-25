//
//  TaskCell.swift
//  Reminders
//
//  Created by Brad Kang on 2022-01-20.
//

import SwiftUI

struct TaskCell: View {
    
    @ObservedObject var task: Task
    
    // A derived value connected to boolean on ContentView
    @Binding var triggersUpdate: Bool
    
    var taskColor: Color {
        switch task.priority {
        case .high:
            return Color.red
        case .medium:
            return Color.blue
        case .low:
            return Color.primary
        }
    }
    var body: some View {
        HStack {
            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    
                    // Toggles completion status on items
                    task.completed.toggle()
                    
                    // Force SwiftUI to re-draw the view
                    // Works to make completed tasks to disappear when hiding completed tasks
                    triggersUpdate.toggle()
                }
            Text(task.description)
        }
        .foregroundColor(self.taskColor)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: testData[0], triggersUpdate: .constant(true))
    }
}

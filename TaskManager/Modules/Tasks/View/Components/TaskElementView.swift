//
//  TasElementView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 09/11/2025.
//

import SwiftUI

struct TaskElementView: View {
    let task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    //.foregroundStyle(getPriorityColor(for: task.priority.rawValue))
                if let dueDate = task.dueDate {
                    Text("Due: \(dueDate.formatted(date: .abbreviated, time: .shortened))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TaskElementView(task: Task.sample.first!)
}

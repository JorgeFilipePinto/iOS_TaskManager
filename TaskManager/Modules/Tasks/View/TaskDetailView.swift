//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct TaskDetailView: View {
    let taskId: UUID
    
    var body: some View {
        Text("Task Detail View for task with ID: \(taskId)")
    }
}

#Preview {
    TaskDetailView(taskId: Task.sample.first!.id)
}

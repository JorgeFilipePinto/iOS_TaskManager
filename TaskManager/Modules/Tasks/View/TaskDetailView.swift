//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(task.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Due Date: \(task.dueDate, formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(task.description)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle(task.title)
    }
}

#Preview {
    TaskDetailView(task: Task.sample.first!)
}

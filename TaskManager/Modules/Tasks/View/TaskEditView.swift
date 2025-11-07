//
//  TaskEditView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct TaskEditView: View {
    let taskId: UUID
    
    var body: some View {
        Text("TaskEditView")
    }
}

#Preview {
    TaskEditView(taskId: Task.sample.id)
}

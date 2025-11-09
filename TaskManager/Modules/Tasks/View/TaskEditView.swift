//
//  TaskEditView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct TaskEditView: View {
    let task: Task
    
    var body: some View {
        VStack {

        }
        .navigationTitle(task.title)
    }
}

#Preview {
    TaskEditView(task: Task.sample.first!)
}

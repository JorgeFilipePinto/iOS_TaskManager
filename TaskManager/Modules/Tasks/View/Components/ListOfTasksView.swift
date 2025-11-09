//
//  ListOfTasksView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 09/11/2025.
//

import SwiftUI

struct ListOfTasksView: View {
    let groupedTasks: [Date: [Task]]
    let sectionTitle: (Date) -> String
    let onTapTask: (UUID) -> Void
    
    var body: some View {
        ForEach(groupedTasks.keys.sorted(by: >), id: \.self) { date in
            Section(header: Text(sectionTitle(date))) {
                ForEach(groupedTasks[date] ?? []) { task in
                    Button(action: {
                        onTapTask(task.id)
                    }) {
                        TaskElementView(task: task)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    let groupedTasks = Dictionary(grouping: Task.sample) { task in
        Calendar.current.startOfDay(for: task.createdAt)
    }
    
    let sectionTitleProvider: (Date) -> String = { date in
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Hoje"
        } else if calendar.isDateInYesterday(date) {
            return "Ontem"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    NavigationStack {
        ListOfTasksView(
            groupedTasks: groupedTasks,
            sectionTitle: sectionTitleProvider,
            onTapTask: { taskId in
            }
        )
        .navigationTitle("Preview")
    }
}

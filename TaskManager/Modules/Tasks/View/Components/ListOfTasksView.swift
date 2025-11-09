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
                    TaskElementView(task: task)
                        .swipeActions(edge: .trailing) {
                            Button (action: {
                                //TODO: Implement edit action
                            }) {
                                Image(systemName: "pencil")
                            }
                            Button(action: {
                                //TODO: Implement delete action
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                //TODO: Implement complete action
                            }) {
                                Image(systemName: "checkmark")
                            }
                        }
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

//
//  Task.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: PriorityLevel
    var notes: String?
}


extension Task {
    static var sample: Task {
        Task(id: UUID(), title: "Sample Task", isCompleted: false, dueDate: nil, priority: .medium, notes: nil)
    }
}

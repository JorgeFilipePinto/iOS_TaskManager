//
//  TaskEntity.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation


struct TaskEntity: Codable, Identifiable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: TaskPriorityLevelEntity
    var notes: String?
}


extension TaskEntity {
    init(from domain: Task) {
        self.id = domain.id
        self.title = domain.title
        self.isCompleted = domain.isCompleted
        self.dueDate = domain.dueDate
        self.priority = TaskPriorityLevelEntity(from: domain.priority)
    }
}
    


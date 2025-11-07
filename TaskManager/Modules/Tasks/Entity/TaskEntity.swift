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
    var priority: PriorityLevel
    var notes: String?
}

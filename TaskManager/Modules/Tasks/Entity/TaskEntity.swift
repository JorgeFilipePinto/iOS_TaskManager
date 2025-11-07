//
//  TaskEntity.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation


struct TaskEntity: Codable, Identifiable {
    let id: UUID
    let createdAt: Date
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: String
    var notes: String?
}

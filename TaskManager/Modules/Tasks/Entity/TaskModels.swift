//
//  TaskModels.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

enum TaskModels {
    enum CreateTask {
        struct Request {
            let createdAt: Date
            let title: String
            var isCompleted: Bool
            let dueDate: Date?
            let priority: PriorityLevel
            let notes: String?
        }
        struct Response {
            let taskEntity: TaskEntity
        }
    }
}

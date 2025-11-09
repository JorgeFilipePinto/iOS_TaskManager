//
//  Task.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    let createdAt: Date
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var priority: String
    var notes: String?
}


extension Task {
    static var sample: [Task] {
        [
            Task(
                id: UUID(),
                createdAt: Date(),
                title: "Reunião com cliente",
                isCompleted: false,
                dueDate: Date(),
                priority: "High",
                notes: "Discutir novo projeto"
            ),
            Task(
                id: UUID(),
                createdAt: Date(),
                title: "Revisar código",
                isCompleted: true,
                dueDate: Date().addingTimeInterval(3600),
                priority: "Medium",
                notes: "Pull request #123"
            ),
            Task(
                id: UUID(),
                createdAt: Date().addingTimeInterval(-86400), // Ontem
                title: "Escrever documentação",
                isCompleted: false,
                dueDate: nil,
                priority: "Low",
                notes: "API endpoints"
            ),
            Task(
                id: UUID(),
                createdAt: Date().addingTimeInterval(-172800), // 2 dias atrás
                title: "Fazer backup",
                isCompleted: false,
                dueDate: Date().addingTimeInterval(7200),
                priority: "Low",
                notes: "Backup semanal"
            )
        ]
    }
}

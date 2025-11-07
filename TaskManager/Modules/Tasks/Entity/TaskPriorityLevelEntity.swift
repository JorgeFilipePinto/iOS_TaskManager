//
//  TaskPriorityLevel.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation

enum TaskPriorityLevelEntity: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}


extension TaskPriorityLevelEntity {
    init(from domain: PriorityLevel) {
        switch domain {
        case .low: self = .low
        case .medium: self = .medium
        case .high: self = .high
        }
    }
    
    
    func toDomain() -> PriorityLevel {
        switch self {
        case .low: return .low
        case .medium: return .medium
        case .high: return .high
        }
    }
}

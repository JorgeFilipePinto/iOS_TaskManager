//
//  TaskRouter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI

@Observable
final class TaskRouter {
    var presentSheet: SheetRoute?
    var path: [Route] = []
    var isLoading: Bool = false
    
    enum Route: Hashable {
        case taskList
        case taskDetails(taskId: UUID)
        case taskEdit(taskId: UUID)
    }
    
    enum SheetRoute: Hashable, Identifiable {
        case addTask
        
        var id: String {
            switch self {
            case .addTask: return "addTask"
            }
        }
    }
    
    func closeSheet() {
        presentSheet = nil
    }
    
    func goToCreateTask() {
        presentSheet = .addTask
    }
    
    func goToTaskDetails(taskId: UUID) {
        path.append(.taskDetails(taskId: taskId))
    }
    
    func goToEditTask(taskId: UUID) {
        path.append(.taskEdit(taskId: taskId))
    }
    
    func goBack() {
        _ = path.popLast()
    }
}

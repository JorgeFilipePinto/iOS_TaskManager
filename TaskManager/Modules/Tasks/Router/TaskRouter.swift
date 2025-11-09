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
    }
    
    enum SheetRoute: Hashable, Identifiable {
        case addTask
        case taskDetails(task: Task)
        case taskEdit(task: Task)
        
        var id: String {
            switch self {
            case .addTask: return "addTask"
            case .taskDetails: return "taskDetails"
            case .taskEdit: return "taskEdit"
            }
        }
    }
    
    func closeSheet() {
        presentSheet = nil
    }
    
    func goToCreateTask() {
        presentSheet = .addTask
    }
    
    func navigateToTaskDetail(taskId: UUID) {
        presentSheet = .taskDetails(taskId: taskId)
    }
    
    func goToEditTask(taskId: UUID) {
        path.append(.taskEdit(taskId: taskId))
    }
    
    func goBack() {
        _ = path.popLast()
    }
}

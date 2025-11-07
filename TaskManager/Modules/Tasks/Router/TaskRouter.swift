//
//  TaskRouter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI
import Observation

@Observable
class TaskRouter {
    enum Route: Hashable {
        case taskList
        case taskDetails(taskId: UUID)
        case taskEdit(taskId: UUID)
    }
    
    var path: [Route] = []
    
    func goToTaskList(taskId: UUID) {
        path.append(.taskDetails(taskId: taskId))
    }
    
    func goToEditTask(taskId: UUID) {
        path.append(.taskEdit(taskId: taskId))
    }
    
    func goBack() {
        _ = path.popLast()
    }
}

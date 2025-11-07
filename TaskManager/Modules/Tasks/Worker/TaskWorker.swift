//
//  TaskWorker.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation


final class TaskWorker: TaskWorkerLogic {
    static var shared = TaskWorker()
    
    private var tasks: [TaskEntity] = []
    
    func fetchTasks() -> [TaskEntity] {
        return tasks
    }
    
    func saveTask(_ task: TaskEntity) {
        tasks.append(task)
        print("Task saved: \(task.title) with ID: \(task.id) ")
    }
}

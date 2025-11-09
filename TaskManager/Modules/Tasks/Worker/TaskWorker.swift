//
//  TaskWorker.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation


final class TaskWorker: TaskWorkerLogic {
    static var shared = TaskWorker()
    
    func fetchTasks() -> [TaskEntity] {
        let tasks = DataStorage.shared.fetchTasks()
        return tasks
    }
    
    func saveTask(_ task: TaskEntity) {
        DataStorage.shared.saveTask(task)
        print("Task saved: \(task.title)")
    }
}

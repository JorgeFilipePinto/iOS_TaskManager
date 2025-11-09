//
//  DataStorageLogic.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

protocol TasksDataStorageLogic {
    func saveTask(_ task: TaskEntity)
    func fetchTasks() -> [TaskEntity]
    func updateTask(_ task: TaskEntity)
    func deleteTask(id: UUID)
}

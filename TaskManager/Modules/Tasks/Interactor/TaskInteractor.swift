//
//  TaskInteractor.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation

final class TaskInteractor: TaskInteractorLogic {
    var presenter: TaskPresenterLogic?
    private let worker: TaskWorkerLogic
    
    init(worker: TaskWorkerLogic) {
        self.worker = worker
    }
    
    func requestTasks() {
        let tasks = worker.fetchTasks()
        presenter?.presentTasks(tasks: tasks)
    }
}


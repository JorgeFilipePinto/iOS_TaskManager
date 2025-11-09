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
    
    private var tasks: [TaskEntity] = []
    
    init(worker: TaskWorkerLogic) {
        self.worker = worker
    }
    
    func requestTasks() {
        self.tasks = worker.fetchTasks()
        presenter?.presentTasks(tasks: tasks)
    }
}


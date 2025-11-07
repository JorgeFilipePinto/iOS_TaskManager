//
//  NewTaskInteractor.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

final class NewTaskInteractor: NewTaskInteractorLogic {    
    var presenter: NewTaskPresenterLogic?
    private let worker: TaskWorkerLogic
    
    init(worker: TaskWorkerLogic) {
        self.worker = worker
    }
    
    func createTask(request: TaskModels.CreateTask.Request) {
        let task = TaskEntity(
            id: UUID(),
            createdAt: request.createdAt,
            title: request.title,
            isCompleted: false,
            dueDate: request.dueDate,
            priority: request.priority.description,
            notes: request.notes
        )

        worker.saveTask(task)

        let response = TaskModels.CreateTask.Response(taskEntity: task)
        presenter?.presentTaskCreated(response: response)
    }
}

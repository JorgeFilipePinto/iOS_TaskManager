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
            title: request.title,
            isCompleted: false,
            dueDate: request.dueDate,
            priority: request.priority,
            notes: request.notes
        )
        print("task send to worker")
        worker.saveTask(task)
        print("Interactor: Task Created with title \(request.title)")
        let response = TaskModels.CreateTask.Response(taskEntity: task)
        presenter?.presentTaskCreated(response: response)
    }
}

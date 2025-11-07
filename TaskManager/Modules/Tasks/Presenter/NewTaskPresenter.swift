//
//  NewTaskPresenter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

final class NewTaskPresenter: NewTaskPresenterLogic {
    weak var viewController: NewTaskViewController?
    
    func presentTaskCreated(response: TaskModels.CreateTask.Response) {
        let task = Task(
            id: response.taskEntity.id,
            createdAt: response.taskEntity.createdAt,
            title: response.taskEntity.title,
            isCompleted: response.taskEntity.isCompleted,
            dueDate: response.taskEntity.dueDate,
            priority: response.taskEntity.priority,
            notes: response.taskEntity.notes
        )
        print("Presenter: Task Created with title \(task.title)")
        print("Presenter: viewController is nil? \(viewController == nil)")
        viewController?.dissmissSheet()
    }
}

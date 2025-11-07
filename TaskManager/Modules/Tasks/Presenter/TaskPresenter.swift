//
//  TaskPresenter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

final class TaskPresenter: TaskPresenterLogic {
    weak var viewController: TaskViewControllerLogic?
    
    func presentTasks(tasks: [TaskEntity]) {
        let taskModels: [Task] = tasks.map { taskEntity in
            Task(id: taskEntity.id,
                 createdAt: taskEntity.createdAt,
                 title: taskEntity.title,
                 isCompleted: taskEntity.isCompleted,
                 dueDate: taskEntity.dueDate,
                 priority: taskEntity.priority.description,
                 notes: taskEntity.notes)
        }
        viewController?.displayTasks(tasks: taskModels)
    }
}

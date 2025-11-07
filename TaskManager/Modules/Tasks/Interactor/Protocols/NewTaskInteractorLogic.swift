//
//  NewTaskInteractorLogic.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

protocol NewTaskInteractorLogic {
    func createTask(request: TaskModels.CreateTask.Request)
}

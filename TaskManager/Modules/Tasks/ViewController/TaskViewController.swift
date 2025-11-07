//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import Foundation

@Observable
final class TaskViewController: TaskViewControllerLogic {
    private let interactor: TaskInteractorLogic
    private let router: TaskRouter
    
    var tasks: [Task] = [] {
        didSet {
            print("Tasks updated: \(tasks)")
        }
    }
    
    init(interactor: TaskInteractorLogic, router: TaskRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    
    func onAppear() {
        interactor.requestTasks()
    }
    
    func sheetIsClosed() {
        interactor.requestTasks()
    }
    
    func onAddTaskTapped() {
        router.goToCreateTask()
    }
    
    func displayTasks(tasks: [Task]) {
        self.tasks = tasks
    }
    
}


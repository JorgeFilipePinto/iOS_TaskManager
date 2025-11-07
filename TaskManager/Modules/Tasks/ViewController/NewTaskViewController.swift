//
//  NewTaskViewController.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

@Observable
class NewTaskViewController {
    private let router: TaskRouter
    private let interactor: NewTaskInteractorLogic
    
    var title: String = ""
    var notes: String = ""
    var dueDate: Date = Date()
    var hasDueDate: Bool = false
    var priority: PriorityLevel = .medium
    
    init(router: TaskRouter, interactor: NewTaskInteractorLogic) {
        self.router = router
        self.interactor = interactor
    }
    
    func onTapSave() {
        let request = TaskModels.CreateTask.Request(
            createdAt: Date(),
            title: title,
            isCompleted: false,
            dueDate: hasDueDate ? dueDate : nil,
            priority: self.priority,
            notes: notes
        )
        interactor.createTask(request: request)
    }
    
    func dissmissSheet() {
        router.closeSheet()
    }
}

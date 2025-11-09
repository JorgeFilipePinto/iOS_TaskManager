//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI

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
    
    func getSectionTitle(for date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Hoje"
        } else if calendar.isDateInYesterday(date) {
            return "Ontem"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    func getPriorityColor(for priority: String) -> Color {
        switch priority {
        case "high":
            return .red
        case "medium":
            return .yellow
        case "low":
            return .green
        default:
            return .primary
        }
    }
}


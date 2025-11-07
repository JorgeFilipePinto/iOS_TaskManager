//
//  TaskViewModelLogic.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation

protocol TaskViewControllerLogic: AnyObject {
    func onAppear()
    func sheetIsClosed()
    func onAddTaskTapped()
    func displayTasks(tasks: [Task])
}


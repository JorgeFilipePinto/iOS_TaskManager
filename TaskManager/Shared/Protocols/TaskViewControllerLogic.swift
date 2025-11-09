//
//  TaskViewModelLogic.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

protocol TaskViewControllerLogic: AnyObject {
    func onAppear()
    func sheetIsClosed()
    func onAddTaskTapped()
    func displayTasks(tasks: [Task])
    func getSectionTitle(for date: Date) -> String
    func getPriorityColor(for priority: String) -> Color
}


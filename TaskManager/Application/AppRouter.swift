//
//  AppRouter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

@Observable
final class AppRouter {
    var home = HomeView()
    var taskRouter = TaskRouter()
    var chartsRouter = ChartsRouter()
    var settingsRouter = SettingsRouter()
}

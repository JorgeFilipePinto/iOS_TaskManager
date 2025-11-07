//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @State private var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appRouter)
        }
    }
}

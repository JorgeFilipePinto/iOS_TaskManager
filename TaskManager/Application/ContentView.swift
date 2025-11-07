//
//  ContentView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI

enum AppTab {
    case home
    case tasks
    case settings
}

struct ContentView: View {
    @Environment(AppRouter.self) private var appRouter
    
    var body: some View {
        TabView {
            NavigationStack() {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(AppTab.home)
            
            NavigationStack() {
                TasksListView(router: appRouter.taskRouter)
            }
            .navigationDestination(for: TaskRouter.Route.self) { route in
            }
            .tabItem { Label("Tasks", systemImage: "list.dash") }
            .tag(AppTab.tasks)
            .overlay {
                if appRouter.taskRouter.isLoading {
                    LoadingView()
                }
            }
            
            NavigationStack() {
                SettingsView()
            }
            .navigationDestination(for: SettingsRouter.Route.self) { route in
                
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
            .tag(AppTab.settings)
        }
    }
}

#Preview {
    ContentView()
        .environment(AppRouter())
}

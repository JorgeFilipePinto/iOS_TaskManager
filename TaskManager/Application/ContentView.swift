//
//  ContentView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 06/11/2025.
//

import SwiftUI

enum AppTab {
    case Home
    case tasksList
    case settings
}

struct ContentView: View {
    @State private var appRouter = AppRouter()
    @State private var selectedTab: AppTab = .tasksList
    
    var body: some View {
        TabView {
            NavigationStack() {
                
            }
            .tabItem { Label("Home", systemImage: "house") }
            .tag(AppTab.Home)
            
            NavigationStack() {
                
            }
            .tabItem { Label("Tasks", systemImage: "list.dash") }
            .tag(AppTab.tasksList)
            
            NavigationStack() {
                
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
            .tag(AppTab.settings)
        }
        .environment(appRouter)
    }
}

#Preview {
    ContentView()
}

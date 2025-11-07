//
//  SettingsRouter.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

@Observable
class SettingsRouter {
    enum Route: Hashable {
        case profile
        case userAccount
        case appSettings
    }
    
    /*@ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .profille:
        case .userAccount:
        case .appSettings:
        }
    }*/
    
    var path: [Route] = []
    
    func goToProfile(taskId: UUID) {
        //path.append
    }
    
    func goToUserAccount() {

    }
    
    func goBack() {
        _ = path.popLast()
    }
    
}

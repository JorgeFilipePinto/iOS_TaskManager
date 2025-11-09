//
//  TasksListView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct TasksListView: View {
    @State private var viewController: TaskViewController
    private let router: TaskRouter
    
    init(router: TaskRouter) {
        self.router = router
        
        let presenter = TaskPresenter()
        let worker = TaskWorker.shared
        let interactor = TaskInteractor(worker: worker)
        let viewController = TaskViewController(interactor: interactor, router: router)
        interactor.presenter = presenter
        presenter.viewController = viewController
        _viewController = State(wrappedValue: viewController)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if !viewController.tasks.isEmpty {
                List {
                    ListOfTasksView(
                        groupedTasks: groupedTasks,
                        sectionTitle: { date in
                            viewController.getSectionTitle(for: date)
                        },
                        onTapTask: { taskId in
                            router.navigateToTaskDetail(taskId: taskId)
                        }
                    )
                }
                .listStyle(.insetGrouped)
            } else {
                EmptyListView()
            }
        }
        .navigationTitle("Minhas Tarefas")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                addButton
            }
        }
        .sheet(item: Binding(
            get: { router.presentSheet },
            set: { router.presentSheet = $0 }
        )) { route in
            sheetContent(for: route)
        }
        .onAppear {
            viewController.onAppear()
        }
        .onChange(of: router.presentSheet) { oldValue, newValue in
            if oldValue == .addTask && newValue == nil {
                viewController.sheetIsClosed()
            }
        }
    }
    
    private var groupedTasks: [Date: [Task]] {
        Dictionary(grouping: viewController.tasks) { task in
            Calendar.current.startOfDay(for: task.createdAt)
        }
    }
    
    
    private var addButton: some View {
        Button {
            viewController.onAddTaskTapped()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    @ViewBuilder
    private func sheetContent(for route: TaskRouter.SheetRoute) -> some View {
        switch route {
        case .addTask:
            NewTaskView(router: router)
        case .taskDetails(taskId: let taskId):
            TaskDetailView(taskId: taskId)
        }
    }
}


#Preview {
    NavigationStack {
        TasksListView(router: TaskRouter())
    }
}


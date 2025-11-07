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
                List(viewController.tasks) { task in
                    NavigationLink(destination: TaskDetailView(taskId: task.id)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.headline)
                                if let dueDate = task.dueDate {
                                    Text("Due: \(dueDate.formatted(date: .abbreviated, time: .shortened))")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
            } else {
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 60))
                    .foregroundStyle(.gray)
                
                Text("Nenhuma tarefa")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Adicione sua primeira tarefa tocando no botão +")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Minhas Tarefas")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    viewController.onAddTaskTapped()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(item: Binding(
            get: { router.presentSheet },
            set: { router.presentSheet = $0 }
        )) { route in
            switch route {
            case .addTask:
                NewTaskView(router: router)
            }
        }
        .onAppear {
            viewController.onAppear()
        }
        .onChange(of: router.presentSheet) { oldValue, newValue in
              if oldValue == .addTask && newValue == nil {
                  print("📱 TasksListView: Sheet fechada, recarregando lista")
                  viewController.sheetIsClosed()
              }
          }
    }
}

#Preview {
    NavigationStack {
        TasksListView(router: TaskRouter())
    }
}


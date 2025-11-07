//
//  NewTaskView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct NewTaskView: View {
    @State private var viewController: NewTaskViewController
    let router: TaskRouter
    
    init(router: TaskRouter) {
        self.router = router
        let presenter = NewTaskPresenter()
        let worker = TaskWorker.shared
        let interactor = NewTaskInteractor(worker: worker)
        
        let viewController = NewTaskViewController(router: router, interactor: interactor)
        interactor.presenter = presenter
        presenter.viewController = viewController
        _viewController = State(wrappedValue: viewController)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Informações") {
                    TextField("Título da tarefa", text: $viewController.title)
                    
                    Picker("Prioridade", selection: $viewController.priority) {
                        ForEach(PriorityLevel.allCases, id: \.self) { level in
                            Text(level.description).tag(level)
                        }
                    }
                }
                
                Section("Data de Vencimento") {
                    Toggle("Adicionar data de vencimento", isOn: $viewController.hasDueDate)
                    
                    if viewController.hasDueDate {
                        DatePicker("Data", selection: $viewController.dueDate, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                Section("Notas") {
                    TextEditor(text: $viewController.notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Nova Tarefa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        viewController.dissmissSheet()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        viewController.onTapSave()
                    }
                    .disabled(viewController.title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NewTaskView(router: TaskRouter())
}

# Fluxo Detalhado da Arquitetura VIP - TaskManager

## 🎯 Inicialização da View (TasksListView)

### 1. ContentView injeta o Router

```swift
// ContentView.swift
@Environment(AppRouter.self) private var appRouter

NavigationStack() {
    TasksListView(router: appRouter.taskRouter)  // ← Router injetado aqui
}
```

### 2. TasksListView monta o ciclo VIP

```swift
// TasksListView.swift
struct TasksListView: View {
    @State private var viewModel: TaskViewModel
    private let router: TaskRouter  // ← Router recebido
    
    init(router: TaskRouter) {
        self.router = router  // ← Guarda referência
        
        // Cria os componentes do VIP
        let presenter = TaskPresenter()
        let interactor = TaskInteractor()
        let viewModel = TaskViewModel(interactor: interactor, router: router)
        
        // Conecta o ciclo VIP
        interactor.presenter = presenter      // Interactor → Presenter
        presenter.viewModel = viewModel       // Presenter → ViewModel (weak)
        
        _viewModel = State(wrappedValue: viewModel)
    }
}
```

## 🔄 Fluxo Completo: Adicionar Nova Tarefa

```
┌─────────────┐
│ ContentView │ @Environment(AppRouter.self)
└──────┬──────┘
       │ injeta appRouter.taskRouter
       ↓
┌──────────────┐
│ TasksListView│ init(router: TaskRouter)
└──────┬───────┘
       │ monta VIP cycle
       ↓
┌─────────────────────────────────────────────────────┐
│         CICLO VIP (Unidirecional)                   │
│                                                     │
│  1. User toca botão "+"                            │
│     ↓                                              │
│  2. View → ViewModel.onAddTaskTapped()             │
│     ↓                                              │
│  3. ViewModel → Interactor.requestCreateTask()     │
│     ↓                                              │
│  4. Interactor → Presenter.presentCreateTaskScreen()│
│     ↓                                              │
│  5. Presenter → ViewModel.displayCreateTask()      │
│     ↓                                              │
│  6. ViewModel → Router.goToCreateTask()            │
│     ↓                                              │
│  7. Router.presentSheet = .addTask                 │
│     ↓                                              │
│  8. View reage ao @Observable router               │
│     ↓                                              │
│  9. Sheet apresenta NewTaskView()                  │
└─────────────────────────────────────────────────────┘
```

## 📊 Diagrama de Componentes

```
┌──────────────────────────────────────────────────────┐
│                    ContentView                       │
│  @Environment(AppRouter.self) private var appRouter  │
└────────────────────┬─────────────────────────────────┘
                     │
                     │ injeta
                     ↓
           ┌─────────────────┐
           │    AppRouter    │
           │  @Observable    │
           ├─────────────────┤
           │ taskRouter      │──┐
           │ settingsRouter  │  │
           └─────────────────┘  │
                                │ passa para
                                ↓
                    ┌───────────────────┐
                    │  TasksListView    │
                    │  init(router)     │
                    └─────────┬─────────┘
                              │ cria
        ┌─────────────────────┼─────────────────────┐
        ↓                     ↓                     ↓
  ┌──────────┐        ┌──────────┐         ┌──────────┐
  │Interactor│        │Presenter │         │ViewModel │
  └────┬─────┘        └────┬─────┘         └────┬─────┘
       │                   │                    │
       │ presenter ────────┘                    │
       │                                        │
       └───────────── router ───────────────────┘
```

## 🔗 Conexões e Referências

### Strong References (→)
- **TasksListView** → **TaskViewModel** (`@State`)
- **TasksListView** → **TaskRouter** (`let`)
- **TaskViewModel** → **TaskInteractor** (`private let`)
- **TaskViewModel** → **TaskRouter** (`private let`)
- **TaskInteractor** → **TaskPresenter** (`var`)

### Weak References (⇢)
- **TaskPresenter** ⇢ **TaskViewModel** (`weak var`)

> ⚠️ **Importante**: O Presenter usa `weak var` para evitar retain cycle, pois o ViewModel também mantém referência ao Interactor que mantém referência ao Presenter.

## 📝 Código Completo Comentado

### TasksListView.swift
```swift
struct TasksListView: View {
    @State private var viewModel: TaskViewModel  // Estado da view
    private let router: TaskRouter               // Router compartilhado
    
    init(router: TaskRouter) {
        self.router = router
        
        // 1. Criar componentes VIP
        let presenter = TaskPresenter()
        let interactor = TaskInteractor()
        let viewModel = TaskViewModel(
            interactor: interactor, 
            router: router
        )
        
        // 2. Conectar o ciclo
        interactor.presenter = presenter  // Interactor conhece Presenter
        presenter.viewModel = viewModel   // Presenter conhece ViewModel
        
        // 3. Inicializar @State
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            // UI aqui
        }
        // Binding bidirecional com router para sheets
        .sheet(item: Binding(
            get: { router.presentSheet },
            set: { router.presentSheet = $0 }
        )) { route in
            router.sheetDestination(for: route)
        }
    }
}
```

### TaskViewModel.swift
```swift
@Observable
final class TaskViewModel: TaskViewModelLogic {
    private let interactor: TaskInteractorLogic  // Para lógica de negócio
    private let router: TaskRouter               // Para navegação
    
    init(interactor: TaskInteractorLogic, router: TaskRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // INPUT: Ações da View
    func onAddTaskTapped() {
        interactor.requestCreateTask()  // Delega ao Interactor
    }
    
    // OUTPUT: Comandos do Presenter
    func displayCreateTask() {
        router.goToCreateTask()  // Usa Router para navegar
    }
}
```

### TaskInteractor.swift
```swift
final class TaskInteractor: TaskInteractorLogic {
    var presenter: TaskPresenterLogic?
    
    func requestCreateTask() {
        // Lógica de negócio aqui (validações, etc)
        
        // Envia resposta ao Presenter
        presenter?.presentCreateTaskScreen()
    }
}
```

### TaskPresenter.swift
```swift
final class TaskPresenter: TaskPresenterLogic {
    weak var viewModel: TaskViewModelLogic?  // weak para evitar retain cycle
    
    func presentCreateTaskScreen() {
        // Formata dados se necessário
        
        // Envia comando ao ViewModel
        viewModel?.displayCreateTask()
    }
}
```

### TaskRouter.swift
```swift
@Observable
final class TaskRouter {
    var presentSheet: SheetRoute?  // Observável para sheets
    var path: [Route] = []         // Para NavigationStack
    
    func goToCreateTask() {
        presentSheet = .addTask  // Trigger sheet
    }
    
    @ViewBuilder
    func sheetDestination(for route: SheetRoute) -> some View {
        switch route {
        case .addTask:
            NewTaskView()
        }
    }
}
```

## ✅ Vantagens desta Abordagem

1. **Router Centralizado**: Um único `AppRouter` gerencia todos os routers do app
2. **Injeção de Dependência**: Router é injetado, facilitando testes
3. **Separação de Responsabilidades**: Cada componente tem uma função clara
4. **Testabilidade**: Cada componente pode ser testado isoladamente
5. **Fluxo Unidirecional**: Dados fluem em uma única direção
6. **Memória Gerenciada**: Uso correto de `weak` evita memory leaks

## 🎓 Padrões Utilizados

- **Dependency Injection**: Router injetado via init
- **Observer Pattern**: @Observable para reatividade
- **Protocol-Oriented**: Protocols para cada componente (Logic)
- **Unidirectional Data Flow**: Dados fluem View → Interactor → Presenter → ViewModel → View
- **Separation of Concerns**: Cada camada tem uma responsabilidade única

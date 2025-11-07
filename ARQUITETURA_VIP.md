# Arquitetura VIP (View-Interactor-Presenter) - TaskManager

## 📋 Visão Geral

A arquitetura VIP é um padrão de design que promove separação de responsabilidades e testabilidade. O fluxo de dados é **unidirecional** e segue este ciclo:

```
View → Interactor → Presenter → ViewModel → View
        ↑                                      ↓
        └──────────────── Router ─────────────┘
```

## 🏗️ Estrutura de Navegação

O app usa um **AppRouter** centralizado que é injetado via `@Environment`:

```swift
@Observable
final class AppRouter {
    var taskRouter = TaskRouter()
    var settingsRouter = SettingsRouter()
}
```

Este router é passado para as views através de injeção de dependência no `ContentView`:

```swift
NavigationStack() {
    TasksListView(router: appRouter.taskRouter)  // Router injetado
}
```

## 🏗️ Componentes da Arquitetura

### 1. **View** (TasksListView)
- **Responsabilidade**: Interface do usuário
- **Função**: Captura eventos do usuário e exibe dados
- **Comunicação**: Chama métodos do ViewModel em resposta a ações do usuário
- **Injeção**: Recebe o `TaskRouter` do `AppRouter` via parâmetro do `init`

```swift
struct TasksListView: View {
    @State private var viewModel: TaskViewModel
    private let router: TaskRouter  // Injetado via init
    
    init(router: TaskRouter) {
        self.router = router
        // Monta o ciclo VIP
        let presenter = TaskPresenter()
        let interactor = TaskInteractor()
        let viewModel = TaskViewModel(interactor: interactor, router: router)
        
        interactor.presenter = presenter
        presenter.viewModel = viewModel
        _viewModel = State(wrappedValue: viewModel)
    }
}
```

### 2. **ViewModel** (TaskViewModel)
- **Responsabilidade**: Gerencia o estado da view e coordena entre View e Interactor
- **Função**: Recebe ações da View e delega lógica de negócio ao Interactor
- **Comunicação**: 
  - Recebe chamadas da View
  - Chama métodos do Interactor para processar lógica de negócio
  - Recebe respostas formatadas do Presenter

```swift
func onAddTaskTapped() {
    interactor.requestCreateTask()  // 2. ViewModel delega ao Interactor
}

func displayCreateTask() {
    router.goToCreateTask()  // 5. ViewModel usa Router para navegar
}
```

### 3. **Interactor** (TaskInteractor)
- **Responsabilidade**: Lógica de negócio
- **Função**: Processa regras de negócio, valida dados, coordena Workers
- **Comunicação**: 
  - Recebe requests do ViewModel
  - Envia responses para o Presenter

```swift
func requestCreateTask() {
    presenter?.presentCreateTaskScreen()  // 3. Interactor envia ao Presenter
}
```

### 4. **Presenter** (TaskPresenter)
- **Responsabilidade**: Formatação de dados para apresentação
- **Função**: Transforma dados de negócio em formato adequado para a View
- **Comunicação**: 
  - Recebe dados do Interactor
  - Formata e envia para o ViewModel

```swift
func presentCreateTaskScreen() {
    viewModel?.displayCreateTask()  // 4. Presenter formata e envia ao ViewModel
}
```

### 5. **Router** (TaskRouter)
- **Responsabilidade**: Navegação
- **Função**: Gerencia toda a navegação entre telas
- **Comunicação**: Chamado pelo ViewModel para realizar navegações

```swift
func goToCreateTask() {
    presentSheet = .addTask  // 6. Router gerencia navegação
}
```

### 6. **Entity** (TaskEntity)
- **Responsabilidade**: Modelos de dados da camada de negócio
- **Função**: Representa estruturas de dados usadas pelo Interactor

## 🔄 Fluxo de Dados Completo

### Exemplo: Adicionar Nova Tarefa

1. **Usuário toca no botão "Adicionar Tarefa"**
   ```swift
   // View (TasksListView)
   Button("➕ Adicionar Tarefa") {
       viewModel.onAddTaskTapped()
   }
   ```

2. **ViewModel recebe a ação e delega ao Interactor**
   ```swift
   // ViewModel (TaskViewModel)
   func onAddTaskTapped() {
       interactor.requestCreateTask()
   }
   ```

3. **Interactor processa a lógica de negócio**
   ```swift
   // Interactor (TaskInteractor)
   func requestCreateTask() {
       // Aqui poderia ter validações, regras de negócio, etc.
       presenter?.presentCreateTaskScreen()
   }
   ```

4. **Presenter formata a resposta**
   ```swift
   // Presenter (TaskPresenter)
   func presentCreateTaskScreen() {
       viewModel?.displayCreateTask()
   }
   ```

5. **ViewModel recebe e usa o Router**
   ```swift
   // ViewModel (TaskViewModel)
   func displayCreateTask() {
       router.goToCreateTask()
   }
   ```

6. **Router executa a navegação**
   ```swift
   // Router (TaskRouter)
   func goToCreateTask() {
       presentSheet = .addTask
   }
   ```

7. **View reage à mudança de estado e apresenta o sheet**
   ```swift
   // View (TasksListView)
   .sheet(item: Binding(
       get: { router.presentSheet },
       set: { router.presentSheet = $0 }
   )) { route in
       router.sheetDestination(for: route)
   }
   ```

## 📁 Estrutura de Arquivos

```
Modules/Tasks/
├── Entity/
│   ├── TaskEntity.swift
│   └── TaskPriorityLevelEntity.swift
├── Interactor/
│   ├── TaskInteractor.swift          // Implementação
│   └── TaskInteractorLogic.swift     // Protocol
├── Presenter/
│   ├── TaskPresenter.swift           // Implementação
│   └── TaskPresenterLogic.swift      // Protocol
├── Router/
│   └── TaskRouter.swift              // Navegação
├── View/
│   ├── TasksListView.swift
│   ├── NewTaskView.swift
│   ├── TaskDetailView.swift
│   └── TaskEditView.swift
├── ViewModel/
│   ├── TaskViewModel.swift           // Implementação
│   └── TaskViewModelLogic.swift      // Protocol
└── Worker/
    └── (Workers de tarefas específicas)
```

## ✅ Vantagens da Arquitetura VIP

1. **Testabilidade**: Cada componente pode ser testado isoladamente
2. **Separação de Responsabilidades**: Cada camada tem uma função bem definida
3. **Fluxo Unidirecional**: Facilita o entendimento do fluxo de dados
4. **Escalabilidade**: Fácil adicionar novos recursos sem afetar o existente
5. **Manutenibilidade**: Código organizado e fácil de manter

## 🔧 Boas Práticas

1. **Use Protocols**: Defina protocolos para cada componente (Logic protocols)
2. **Injeção de Dependências**: Injete dependências no inicializador
3. **Weak References**: Use `weak` para evitar retain cycles (Presenter → ViewModel)
4. **Entities vs Models**: 
   - **Entity**: Dados da camada de negócio (usado pelo Interactor)
   - **Model**: Dados da camada de apresentação (usado pela View)

## 🎯 Próximos Passos

Para completar a implementação VIP:

1. [ ] Implementar Workers para operações específicas (ex: TaskStorageWorker)
2. [ ] Adicionar lógica de persistência de dados
3. [ ] Implementar testes unitários para cada camada
4. [ ] Adicionar validações de negócio no Interactor
5. [ ] Criar Models de apresentação no Presenter quando necessário

## 📚 Referências

- Clean Swift (VIP Architecture): https://clean-swift.com
- VIPER vs VIP: Similar but VIP has a unidirectional data flow

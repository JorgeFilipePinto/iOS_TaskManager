//
//  TasksDataStorage.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation
import CoreData

extension DataStorage: TasksDataStorageLogic {
    
    func fetchTasks() -> [TaskEntity] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        do {
            let results = try viewContext.fetch(request)
            
            // ✅ Usa compactMap corretamente - retorna Optional
            let tasks: [TaskEntity] = results.compactMap { obj -> TaskEntity? in
                guard
                    let id = obj.value(forKey: "id") as? UUID,
                    let title = obj.value(forKey: "title") as? String,
                    let createdAt = obj.value(forKey: "createdAt") as? Date
                else {
                    print("⚠️ Skipping invalid task object")
                    return nil  // ✅ Agora está correto com Optional
                }
                
                let isCompleted = obj.value(forKey: "isCompleted") as? Bool ?? false
                let dueDate = obj.value(forKey: "dueDate") as? Date
                let priorityRaw = obj.value(forKey: "priority") as? String ?? "medium"
                let priority = PriorityLevel(rawValue: priorityRaw) ?? .medium
                let notes = obj.value(forKey: "notes") as? String ?? ""
                
                return TaskEntity(
                    id: id,
                    createdAt: createdAt,
                    title: title,
                    isCompleted: isCompleted,
                    dueDate: dueDate,
                    priority: priority.description,
                    notes: notes
                )
            }
            
            print("✅ DataStorage: \(tasks.count) tasks fetched from Core Data")
            return tasks
            
        } catch {
            print("❌ Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func saveTask(_ task: TaskEntity) {
        print("🔧 DataStorage: Saving task '\(task.title)'")
        
        // ✅ Criar novo NSManagedObject
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: viewContext) else {
            print("❌ Failed to get entity description for Tasks")
            return
        }
        
        let taskObject = NSManagedObject(entity: entity, insertInto: viewContext)
        
        // ✅ Setar valores
        taskObject.setValue(task.id, forKey: "id")
        taskObject.setValue(task.title, forKey: "title")
        taskObject.setValue(task.notes, forKey: "notes")
        taskObject.setValue(task.dueDate, forKey: "dueDate")
        taskObject.setValue(task.priority.description, forKey: "priority")
        taskObject.setValue(task.isCompleted, forKey: "isCompleted")
        taskObject.setValue(task.createdAt, forKey: "createdAt")
        
        // ✅ Salvar contexto
        saveContext()
        
        print("✅ DataStorage: Task saved successfully")
    }
    
    func updateTask(_ task: TaskEntity) {
        print("🔧 DataStorage: Updating task '\(task.title)'")
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let results = try viewContext.fetch(request)
            
            guard let taskObject = results.first else {
                print("❌ Task not found for update")
                return
            }
            
            // ✅ Atualizar valores
            taskObject.setValue(task.title, forKey: "title")
            taskObject.setValue(task.notes, forKey: "notes")
            taskObject.setValue(task.dueDate, forKey: "dueDate")
            taskObject.setValue(task.priority.description, forKey: "priority")
            taskObject.setValue(task.isCompleted, forKey: "isCompleted")
            
            // ✅ Salvar
            saveContext()
            
            print("✅ DataStorage: Task updated successfully")
            
        } catch {
            print("❌ Failed to update task: \(error)")
        }
    }
    
    func deleteTask(id: UUID) {
        print("🔧 DataStorage: Deleting task with id \(id)")
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Tasks")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            let results = try viewContext.fetch(request)
            
            guard let taskObject = results.first else {
                print("❌ Task not found for deletion")
                return
            }
            
            viewContext.delete(taskObject)
            saveContext()
            
            print("✅ DataStorage: Task deleted successfully")
            
        } catch {
            print("❌ Failed to delete task: \(error)")
        }
    }
}

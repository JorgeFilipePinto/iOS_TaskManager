//
//  DataStotage.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import Foundation
import CoreData

final class DataStorage {
      static let shared = DataStorage()
      
      private init() {
          print("✅ DataStorage: Inicializado (Singleton)")
      }
      
      // MARK: - Core Data Stack
      
      lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "CoreDataModel")
          container.loadPersistentStores { description, error in
              if let error = error {
                  print("❌ Core Data failed to load: \(error.localizedDescription)")
                  fatalError("Unresolved error \(error)")
              }
              print("✅ Core Data loaded: \(description.url?.lastPathComponent ?? "")")
          }
          return container
      }()
      
      var viewContext: NSManagedObjectContext {
          return persistentContainer.viewContext
      }
      
      // MARK: - Save Context
      
      func saveContext() {
          let context = viewContext
          if context.hasChanges {
              do {
                  try context.save()
                  print("✅ Core Data context saved")
              } catch {
                  let nserror = error as NSError
                  print("❌ Error saving Core Data: \(nserror), \(nserror.userInfo)")
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
  }

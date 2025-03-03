//
//  CoreDataManager.swift
//  ToDoTime
//
//  Created by Ali Hooshmand on 2.03.2025.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoTime") // Name must match your .xcdatamodeld file
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data: \(error)")
            }
        }
    }

    // Function to add a new task
    func addTask(title: String, dueDate: Date) {
        let task = Task(context: context)
        task.title = title
        task.dueDate = dueDate
        task.isCompleted = false
        saveContext()
    }

    // Function to fetch all tasks
    func fetchTasks() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }

    // Function to delete a task
    func deleteTask(task: Task) {
        context.delete(task)
        saveContext()
    }
}

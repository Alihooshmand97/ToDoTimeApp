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
                print("❌ Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed to save Core Data: \(error.localizedDescription)")
            }
        }
    }

    // ✅ Function to add a new task
    func addTask(title: String, dueDate: Date, category: String, priority: String) {
        let task = TaskEntity(context: context) // ✅ Using TaskEntity
        task.title = title
        task.dueDate = dueDate
        task.category = category  // ✅ Added category
        task.priority = priority  // ✅ Added priority
        task.status = "Ongoing"   // ✅ Default status

        saveContext()
    }

    // ✅ Function to fetch all tasks, sorted by due date
    func fetchTasks() -> [TaskEntity] {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)] // Sort by due date

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ Error fetching tasks: \(error.localizedDescription)")
            return []
        }
    }

    // ✅ Fetch tasks by category
    func fetchTasks(for category: String) -> [TaskEntity] {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)]

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ Error fetching tasks for category \(category): \(error.localizedDescription)")
            return []
        }
    }

    // ✅ Function to delete a task
    func deleteTask(task: TaskEntity) {
        context.delete(task)
        saveContext()
    }

    // ✅ Function to update a task's status
    func updateTaskStatus(task: TaskEntity, status: String) {
        task.status = status
        saveContext()
    }
}

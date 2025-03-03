//
//  ContentView.swift
//  ToDoTime
//
//  Created by Ali Hooshmand on 2.03.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var tasks: [Task] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks, id: \.self) { task in
                    HStack {
                        Button(action: {
                            toggleTaskCompletion(task)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle())

                        Text(task.title ?? "No Title")
                            .strikethrough(task.isCompleted, color: .gray)

                        Spacer()
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("ToDoTime")
            .toolbar {
                Button(action: addSampleTask) {
                    Image(systemName: "plus")
                }
            }
            .onAppear {
                tasks = CoreDataManager.shared.fetchTasks()
            }
        }
    }

    func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
        CoreDataManager.shared.saveContext()
        tasks = CoreDataManager.shared.fetchTasks()
    }

    func addSampleTask() {
        CoreDataManager.shared.addTask(title: "New Task", dueDate: Date())
        tasks = CoreDataManager.shared.fetchTasks()
    }

    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            CoreDataManager.shared.deleteTask(task: tasks[index])
        }
        tasks = CoreDataManager.shared.fetchTasks()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

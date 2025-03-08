//
//  ContentView.swift
//  ToDoTime
//
//  Created by Ali Hooshmand on 2.03.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var tasks: [TaskEntity] = []

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

                        VStack(alignment: .leading) {
                            Text(task.title ?? "No Title")
                                .font(.headline)
                                .strikethrough(task.isCompleted, color: .gray)
                            
                            Text("Priority: \(task.priority ?? "Medium")")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            if let dueDate = task.dueDate {
                                Text("Due: \(formattedDate(dueDate))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }

                        Spacer()

                        Text(task.category ?? "No Category")
                            .font(.footnote)
                            .padding(5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
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

    func toggleTaskCompletion(_ task: TaskEntity) {
        CoreDataManager.shared.updateTaskStatus(task: task, status: task.isCompleted ? "Ongoing" : "Done")
        tasks = CoreDataManager.shared.fetchTasks()
    }

    func addSampleTask() {
        CoreDataManager.shared.addTask(title: "New Task", dueDate: Date(), category: "General", priority: "Medium")
        tasks = CoreDataManager.shared.fetchTasks()
    }

    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            CoreDataManager.shared.deleteTask(task: tasks[index])
        }
        tasks = CoreDataManager.shared.fetchTasks()
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


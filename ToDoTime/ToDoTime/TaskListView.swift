import SwiftUI
import CoreData

struct TaskListView: View {
    var category: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)],
        predicate: nil,
        animation: .default
    ) private var tasks: FetchedResults<TaskEntity>

    @State private var newTaskTitle = ""
    @State private var selectedPriority = "Medium"
    @State private var dueDate = Date()

    let priorities = ["High 🔴", "Medium 🟠", "Low 🟢"]
    let statuses = ["Ongoing", "On Hold", "Done"]

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(tasks.filter { $0.category == category }) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.title ?? "Untitled Task")
                                    .font(.headline)
                                    .foregroundColor(task.status == "Done" ? .green : .primary)

                                Text("Priority: \(task.priority ?? "Medium")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Text("Due: \(formattedDate(task.dueDate ?? Date()))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            // Swipe right to mark as done
                            if task.status != "Done" {
                                Button(action: {
                                    markAsDone(task)
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }

                // Task Input Section
                VStack {
                    TextField("Task Title", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    HStack {
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) { priority in
                                Text(priority)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    }
                    .padding(.top, 5)

                    Button(action: addTask) {
                        Text("Add Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("\(category) Tasks")
            .navigationBarBackButtonHidden(false)
        }
    }

    // Add Task with Core Data
    func addTask() {
        if !newTaskTitle.isEmpty {
            let newTask = TaskEntity(context: viewContext)
            newTask.title = newTaskTitle
            newTask.priority = selectedPriority
            newTask.status = "Ongoing"
            newTask.dueDate = dueDate
            newTask.category = category // Assign category

            do {
                try viewContext.save()
                newTaskTitle = ""
                selectedPriority = "Medium"
                dueDate = Date()
            } catch {
                print("Failed to save task: \(error)")
            }
        }
    }

    // Delete Task
    func deleteTask(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }

    // Mark Task as Done
    func markAsDone(_ task: TaskEntity) {
        task.status = "Done"

        do {
            try viewContext.save()
        } catch {
            print("Failed to update task status: \(error)")
        }
    }

    // Format Date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    TaskListView(category: "Example")
        .environment(\.managedObjectContext, CoreDataManager.shared.context)
}

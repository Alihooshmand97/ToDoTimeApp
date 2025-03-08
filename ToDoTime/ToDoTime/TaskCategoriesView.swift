import SwiftUI

struct TaskCategoriesView: View {
    @State private var categories = ["Work", "Personal", "Health", "Study"]
    @State private var newCategory = ""
    @State private var selectedCategory: String?

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category // Set selected category
                        }) {
                            Text(category)
                                .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: deleteCategory)
                }

                HStack {
                    TextField("New Category", text: $newCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addCategory) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                }
                .padding()
            }
            .navigationTitle("Task Categories")
            .toolbar {
                EditButton()
            }
            .navigationDestination(item: $selectedCategory) { category in
                TaskListView(category: category) // Navigate to TaskListView
            }
        }
    }

    func addCategory() {
        if !newCategory.isEmpty {
            categories.append(newCategory)
            newCategory = ""
        }
    }

    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskCategoriesView()
}

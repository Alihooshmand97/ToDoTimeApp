import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            TaskCategoriesView() // Move directly to Task Categories
        } else {
            VStack {
                Image("ToDoTimeLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 20)

                Text("ToDoTime")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                VStack(spacing: 5) {
                    Text("Created by:")
                        .font(.headline)

                    Text("Ali Hooshmandghasrodashti\nStudent ID: 101261322")
                        .multilineTextAlignment(.center)

                    Text("Hooman Afsharnia\nStudent ID: 101466119")
                        .multilineTextAlignment(.center)

                    Text("Group 13")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 20)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
